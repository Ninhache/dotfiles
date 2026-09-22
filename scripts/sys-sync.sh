#!/usr/bin/env bash
# Synchronise les fichiers système versionnés avec /etc.
#   system/common/...          → toutes les machines
#   system/hosts/<hostname>/... → cette machine seulement
#
#   sys-sync.sh diff     différences dépôt ↔ système (par défaut, ne modifie rien)
#   sys-sync.sh pull     système → dépôt   (après avoir modifié un fichier dans /etc)
#   sys-sync.sh install  dépôt → système   (confirmation fichier par fichier + sauvegarde)
set -euo pipefail

DOT="$(cd "$(dirname "$0")/.." && pwd)"
HOST="$(cat /etc/hostname)"
ROOTS=("$DOT/system/common" "$DOT/system/hosts/$HOST")

# Liste "racine<TAB>/chemin/système" pour chaque fichier versionné
entries() {
  for r in "${ROOTS[@]}"; do
    [ -d "$r" ] || continue
    (cd "$r" && find . -type f | sed 's|^\./|/|' | sort) | while read -r f; do printf '%s\t%s\n' "$r" "$f"; done
  done
}

mode="${1:-diff}"
changed=()

while IFS=$'\t' read -r root f; do
  src="$root$f"
  case "$mode" in
    diff)
      if [ ! -e "$f" ]; then echo "ABSENT du système : $f"; changed+=("$f")
      elif ! cmp -s "$src" "$f"; then
        diff -u --label "$f (système)" --label "$f (dépôt)" "$f" "$src" || true
        changed+=("$f")
      fi ;;
    pull)
      if [ -r "$f" ] && ! cmp -s "$f" "$src"; then cp "$f" "$src"; echo "mis à jour dans le dépôt : $f"; changed+=("$f"); fi ;;
    install)
      if [ -e "$f" ] && cmp -s "$src" "$f"; then continue; fi
      echo; echo "──── $f"
      if [ -e "$f" ]; then diff -u --label "actuel" --label "dépôt" "$f" "$src" || true; else echo "(nouveau fichier)"; fi
      read -rp "Installer $f ? [o/N] " a </dev/tty
      [[ "$a" =~ ^[oOyY]$ ]] || continue
      [ -e "$f" ] && sudo cp -a "$f" "$f.$(date +%F-%H%M).bak"
      sudo install -Dm644 "$src" "$f"
      changed+=("$f") ;;
    *) echo "Usage : $(basename "$0") diff|pull|install"; exit 1 ;;
  esac
done < <(entries)

if [ ${#changed[@]} -eq 0 ]; then echo "Tout est synchronisé."; exit 0; fi

case "$mode" in
  pull) echo "Relis puis commite : git -C \"$DOT\" diff" ;;
  install)
    printf '%s\n' "${changed[@]}" | grep -qE '^/etc/(mkinitcpio|modprobe\.d)' && echo "→ À faire : sudo mkinitcpio -P"
    printf '%s\n' "${changed[@]}" | grep -q '^/etc/default/grub' && echo "→ À faire : sudo grub-mkconfig -o /boot/grub/grub.cfg"
    true ;;
esac

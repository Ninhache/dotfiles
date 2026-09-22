#!/usr/bin/env bash
# Installe ces dotfiles sur une machine Arch (neuve ou existante). Relançable sans risque.
#   git clone git@github.com:Ninhache/dotfiles.git ~/dotfiles && ~/dotfiles/bootstrap.sh
set -euo pipefail

DOT="$(cd "$(dirname "$0")" && pwd)"
HOST="$(cat /etc/hostname)"
step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
list() { for f in "$@"; do [ -f "$f" ] && grep -vE '^\s*(#|$)' "$f"; done; true; }

step "Machine : $HOST"
[ -f "$DOT/packages/hosts/$HOST.txt" ] || echo "(pas de liste propre à cette machine : packages/hosts/$HOST.txt)"

step "Outils de base"
sudo pacman -Syu --needed --noconfirm base-devel git stow zsh

step "yay (AUR)"
if ! command -v yay >/dev/null; then
  tmp="$(mktemp -d)"
  git clone --depth 1 https://aur.archlinux.org/yay-bin.git "$tmp/yay-bin"
  (cd "$tmp/yay-bin" && makepkg -si --noconfirm)
  rm -rf "$tmp"
fi

step "Paquets"
mapfile -t pkgs < <(list "$DOT/packages/pacman.txt" "$DOT/packages/aur.txt" "$DOT/packages/hosts/$HOST.txt" | sort -u)
[ ${#pkgs[@]} -gt 0 ] && yay -S --needed "${pkgs[@]}"

step "oh-my-zsh"
[ -d "$HOME/.oh-my-zsh" ] || git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"

step "Liens symboliques (stow)"
backup="$HOME/.dotfiles-backup/$(date +%F-%H%M%S)"
cd "$DOT/home"
for pkg in */; do
  pkg="${pkg%/}"
  # Un fichier déjà présent (et qui n'est pas déjà notre lien) est mis de côté, jamais écrasé
  while IFS= read -r -d '' f; do
    rel="${f#"$pkg"/}"; tgt="$HOME/$rel"
    [ -e "$tgt" ] || continue
    [ "$(realpath "$tgt")" = "$(realpath "$f")" ] && continue
    mkdir -p "$backup/$(dirname "$rel")"
    mv "$tgt" "$backup/$rel"
    echo "  mis de côté : ~/$rel"
  done < <(find "$pkg" -type f -print0)
  stow -d "$DOT/home" -t "$HOME" --restow "$pkg"
  echo "  $pkg"
done
[ -d "$backup" ] && echo "Anciens fichiers sauvegardés dans : $backup"

step "Hook anti-secrets (gitleaks)"
git -C "$DOT" config core.hooksPath .githooks

step "Fichiers système"
"$DOT/scripts/sys-sync.sh" install

step "Services"
mapfile -t svcs < <(list "$DOT/services/system.txt" "$DOT/services/hosts/$HOST.txt")
for s in "${svcs[@]}"; do
  if systemctl cat "$s" >/dev/null 2>&1; then sudo systemctl enable "$s" >/dev/null && echo "  $s"
  else echo "  (ignoré, introuvable) $s"; fi
done

step "Shell par défaut"
[ "$(getent passwd "$USER" | cut -d: -f7)" = "/usr/bin/zsh" ] || chsh -s /usr/bin/zsh

step "Terminé — redémarre pour tout appliquer."

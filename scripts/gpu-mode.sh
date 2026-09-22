#!/usr/bin/env bash
# Bascule le GPU qui fait le rendu de Hyprland : intel | nvidia
# Remplace fix-mkinit.sh : modifie mkinitcpio.conf ET la config Hyprland, puis régénère l'initramfs.
# Usage : gpu-mode.sh intel|nvidia     (sans argument : affiche le mode actuel)
set -euo pipefail

HOST_FILE="$HOME/.config/hypr/hosts/$(cat /etc/hostname).lua"
MKINIT=/etc/mkinitcpio.conf

[ -f "$HOST_FILE" ] || { echo "Introuvable : $HOST_FILE"; exit 1; }
current=$(grep -oP '^\s*gpu\s*=\s*"\K[a-z]+' "$HOST_FILE" || echo "?")

case "${1:-}" in
  intel)  modules="i915" ;;
  nvidia) modules="nvidia nvidia_modeset nvidia_uvm nvidia_drm" ;;
  *)
    echo "Mode actuel : $current"
    echo "  Hyprland : $HOST_FILE"
    echo "  initramfs: $(grep '^MODULES=' "$MKINIT")"
    echo "Usage : $(basename "$0") intel|nvidia"
    exit 0 ;;
esac
mode=$1

if [ "$mode" = "$current" ] && grep -qx "MODULES=($modules)" "$MKINIT"; then
  echo "Déjà en mode $mode, rien à faire."; exit 0
fi

backup="$MKINIT.$(date +%F-%H%M).bak"
echo "→ Sauvegarde : $backup"
sudo cp "$MKINIT" "$backup"

echo "→ mkinitcpio.conf : MODULES=($modules)"
sudo sed -i "s/^MODULES=(.*)/MODULES=($modules)/" "$MKINIT"

echo "→ Hyprland : gpu = \"$mode\""
sed -i -E "s/^(\s*gpu\s*=\s*)\"[a-z]+\"/\1\"$mode\"/" "$HOST_FILE"

echo "→ Régénération de l'initramfs"
sudo mkinitcpio -P

echo
echo "Fait. Vérification :"
grep '^MODULES=' "$MKINIT"
grep -E '^\s*gpu\s*=' "$HOST_FILE"
echo "Redémarre pour appliquer. Retour arrière : $(basename "$0") $current"

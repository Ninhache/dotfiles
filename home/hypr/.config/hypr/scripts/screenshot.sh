#!/usr/bin/env bash
# edit : zone -> swappy | copy : zone -> presse-papiers | full : écran -> fichier + presse-papiers
set -euo pipefail
dir="$HOME/Pictures/screenshots"; mkdir -p "$dir"
f="$dir/$(date +%Y-%m-%d_%H-%M-%S).png"

case "${1:-edit}" in
  edit) grim -g "$(slurp -d)" - | swappy -f - ;;
  copy) grim -g "$(slurp -d)" - | wl-copy ;;
  full)
      grim "$f"
      wl-copy < "$f"
      command -v notify-send >/dev/null && notify-send "Capture d'écran" "$f" ;;
  *) echo "Usage : $(basename "$0") edit|copy|full" >&2; exit 1 ;;
esac

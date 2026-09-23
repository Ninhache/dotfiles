#!/usr/bin/env bash
# Affiche le morceau en cours avec sa pochette.
set -euo pipefail
art="$(playerctl metadata mpris:artUrl 2>/dev/null || true)"
case "$art" in
  file://*) icon="${art#file://}" ;;
  http*)    icon="/tmp/np-cover"; curl -sL "$art" -o "$icon" ;;
  *)        icon="audio-x-generic" ;;
esac
notify-send -i "$icon" \
  "$(playerctl metadata title)" \
  "$(playerctl metadata artist) — $(playerctl metadata album)"

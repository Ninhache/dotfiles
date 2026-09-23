#!/usr/bin/env bash
# Choisit la sortie audio par défaut (wofi) et y déplace les flux en cours.
set -euo pipefail

list() {
  pactl -f json list sinks | python3 -c '
import json,sys
for s in json.load(sys.stdin):
    print(f"{s[\"name\"]}\t{s[\"description\"]}")
'
}

choice="$(list | cut -f2 | wofi --dmenu --prompt "Sortie audio" || true)"
[ -z "$choice" ] && exit 0
sink="$(list | awk -F'\t' -v c="$choice" '$2==c {print $1; exit}')"
[ -z "$sink" ] && exit 1

pactl set-default-sink "$sink"
pactl list short sink-inputs | cut -f1 | while read -r i; do
  [ -n "$i" ] && pactl move-sink-input "$i" "$sink"
done
command -v notify-send >/dev/null && notify-send "Sortie audio" "$choice"

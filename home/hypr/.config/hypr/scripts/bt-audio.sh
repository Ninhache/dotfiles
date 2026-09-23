#!/usr/bin/env bash
# Bascule le profil d'un casque Bluetooth connecté, sans adresse codée en dur.
#   bt-audio.sh music   qualité stéréo (A2DP), sans micro
#   bt-audio.sh call    micro actif (HFP), son mono
#   bt-audio.sh menu    choix dans wofi
set -euo pipefail

card="$(pactl list cards short | awk '/bluez_card/ {print $2; exit}')"
[ -z "${card:-}" ] && { command -v notify-send >/dev/null && notify-send "Bluetooth" "Aucun casque connecté"; exit 1; }

profiles() { pactl list cards | awk -v c="$card" '$0 ~ c {f=1} f && /^\t\t[a-z0-9_-]+: /{print $1}' | tr -d ':'; }

pick() {
  case "$1" in
    music) profiles | grep -m1 -E '^a2dp[-_]sink' || echo a2dp-sink ;;
    call)  profiles | grep -m1 -E '^(headset[-_]head[-_]unit|handsfree)' || echo headset-head-unit ;;
  esac
}

case "${1:-menu}" in
  music|call) p="$(pick "$1")" ;;
  menu)
    sel="$(printf 'Musique (stéréo)\nAppel (micro)\n' | wofi --dmenu --prompt "Casque Bluetooth" || true)"
    case "$sel" in
      Musique*) p="$(pick music)" ;;
      Appel*)   p="$(pick call)" ;;
      *) exit 0 ;;
    esac ;;
  *) echo "Usage : $(basename "$0") music|call|menu" >&2; exit 1 ;;
esac

pactl set-card-profile "$card" "$p"
command -v notify-send >/dev/null && notify-send "Casque Bluetooth" "Profil : $p"

#!/usr/bin/env bash
# Compteur de mises à jour en attente, pour waybar (sortie JSON).
pac=$(checkupdates 2>/dev/null | wc -l)
aur=$(yay -Qua 2>/dev/null | wc -l)
tot=$(( pac + aur ))
if [ "$tot" -lt 10 ]; then
  echo '{"text":"","tooltip":"Système à jour"}'
else
  printf '{"text":"%s","tooltip":"%s yay · %s AUR"}\n' "$tot" "$pac" "$aur"
fi

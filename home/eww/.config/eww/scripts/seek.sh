#!/usr/bin/env bash
# seek.sh <pourcentage> <durée en secondes>
set -euo pipefail
pct="${1:-0}"; len="${2:-0}"
[ "${len%.*}" -gt 0 ] 2>/dev/null || exit 0
playerctl position "$(python3 -c "print(round(float('$pct')/100*float('$len'), 2))")"

#!/usr/bin/env python3
"""Émet l'état du lecteur en JSON, une ligne par seconde, pour eww (deflisten)."""
import json, os, subprocess, sys, time, urllib.request, hashlib

CACHE = "/tmp/eww-covers"
os.makedirs(CACHE, exist_ok=True)

def pc(*args):
    try:
        out = subprocess.run(["playerctl", *args], capture_output=True, text=True, timeout=2)
        return out.stdout.strip() if out.returncode == 0 else ""
    except Exception:
        return ""

def fmt(sec):
    sec = max(int(sec), 0)
    return f"{sec // 60}:{sec % 60:02d}"


def cover(url):
    if not url:
        return ""
    if url.startswith("file://"):
        return url[7:]
    path = os.path.join(CACHE, hashlib.sha1(url.encode()).hexdigest() + ".img")
    if not os.path.exists(path):
        try:
            urllib.request.urlretrieve(url, path)
        except Exception:
            return ""
    return path

last = None
while True:
    status = pc("status")
    if not status:
        data = {"status": "Stopped", "title": "Rien en lecture", "artist": "",
                "album": "", "art": "", "position": 0, "length": 1, "player": "",
                "pos_str": "0:00", "len_str": "0:00"}
    else:
        try:
            length = int(pc("metadata", "mpris:length") or 0) // 1_000_000
        except ValueError:
            length = 0
        try:
            position = int(float(pc("position") or 0))
        except ValueError:
            position = 0
        data = {
            "status": status,
            "title": pc("metadata", "title") or "—",
            "artist": pc("metadata", "artist"),
            "album": pc("metadata", "album"),
            "art": cover(pc("metadata", "mpris:artUrl")),
            "position": position,
            "length": max(length, 1),
            "pos_str": fmt(position),
            "len_str": fmt(length),
            "player": pc("-l").split("\n")[0] if pc("-l") else "",
        }
    line = json.dumps(data, ensure_ascii=False)
    if line != last:
        print(line, flush=True)
        last = line
    time.sleep(1)

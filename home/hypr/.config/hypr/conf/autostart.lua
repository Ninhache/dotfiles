-- Lancé une seule fois, au démarrage de Hyprland (pas à chaque reload).
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaybg -m fill -i ~/.config/hypr/background_images/mark-of-sacrifice-blurred.png")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("eww daemon")
    -- Historique du presse-papiers (texte et images)
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    -- Terminal escamotable, prêt en arrière-plan
    hl.exec_cmd("kitty --class scratchpad")
end)

-- Lancé une seule fois, au démarrage de Hyprland (pas à chaque reload).
-- Les portails XDG et l'export de WAYLAND_DISPLAY vers systemd/dbus sont
-- gérés par Hyprland lui-même : l'ancien script xdg-portal-hyprland est retiré.
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaybg -m fill -i ~/.config/hypr/background_images/mark-of-sacrifice-blurred.png")
end)

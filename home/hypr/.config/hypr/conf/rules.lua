-- Voir https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Les applis ne peuvent pas se maximiser d'elles-mêmes (ça casse le tiling)
hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Corrige le glisser-déposer des applis XWayland
hl.window_rule({
    name = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

-- Fenêtres de dialogue et petits utilitaires en flottant, centrés
hl.window_rule({
    name = "float-dialogs",
    match = { title = "^(Open File|Save File|Save As|Ouvrir.*|Enregistrer.*|File Operation Progress|Opération sur les fichiers.*)$" },
    float = true,
    center = true,
})

hl.window_rule({
    name = "float-polkit",
    match = { class = "^(polkit-gnome-authentication-agent-1)$" },
    float = true,
    center = true,
})

-- Terminal escamotable (SUPER + T)
hl.window_rule({
    name = "scratchpad-term",
    match = { class = "^(scratchpad)$" },
    workspace = "special:term",
})

-- Flou derrière la barre et le lanceur
hl.layer_rule({ name = "blur-waybar", match = { namespace = "^waybar$" }, blur = true, ignore_alpha = 0.3 })
hl.layer_rule({ name = "blur-wofi",   match = { namespace = "^wofi$" },   blur = true, ignore_alpha = 0.3 })

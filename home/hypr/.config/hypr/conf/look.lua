hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 4,
        border_size = 4,
        layout      = "dwindle",
        col = {
            active_border   = { colors = { "rgba(4B0000FF)", "rgba(FF0000FF)" }, angle = 195 },
            inactive_border = "rgba(595959FF)",
        },
    },

    decoration = {
        blur = {
            enabled = true,
            size    = 5,   -- était 7
            passes  = 2,   -- était 3 : c'est le réglage le plus coûteux pour l'iGPU
        },
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo = true,
    },

    animations = {
        enabled = true,
    },
})

-- Courbes, voir https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 265.2633, dampening = 25.8273644 })

hl.animation({ leaf = "global",     enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",     enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "layers",     enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",    enabled = true, speed = 3,    spring = "easy" })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 2.5,  spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "fade",       enabled = true, speed = 2,    bezier = "quick" })

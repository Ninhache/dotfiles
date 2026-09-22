-- Voir https://wiki.hypr.land/Configuring/Basics/Binds/
local mod = "SUPER"
local function key(k) return mod .. " + " .. k end
local function shift(k) return mod .. " + SHIFT + " .. k end

-- Applications
hl.bind(key("Q"),      hl.dsp.exec_cmd("kitty"))
hl.bind(key("Return"), hl.dsp.exec_cmd("kitty"))
hl.bind(key("E"),      hl.dsp.exec_cmd("thunar"))
hl.bind(key("SPACE"),  hl.dsp.exec_cmd("wofi"))
hl.bind(key("S"),      hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))

-- Session
hl.bind(key("L"),      hl.dsp.exec_cmd("swaylock"))
hl.bind(key("M"),      hl.dsp.exec_cmd("wlogout --protocol layer-shell"))
hl.bind(shift("M"),    hl.dsp.exit())
hl.bind(key("O"),      hl.dsp.dpms("on"))

-- Fenêtres
hl.bind(shift("X"),    hl.dsp.window.close())
hl.bind(key("V"),      hl.dsp.window.float())
hl.bind(key("F"),      hl.dsp.window.fullscreen())
hl.bind(key("P"),      hl.dsp.window.pseudo())
hl.bind(key("J"),      hl.dsp.layout("togglesplit"))

-- Focus
for _, dir in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(key(dir), hl.dsp.focus({ direction = dir }))
end

-- Espaces de travail : keycodes 10-19 = rangée des chiffres (indépendant de l'AZERTY)
for i = 1, 10 do
    local code = "code:" .. (9 + i)
    hl.bind(key(code),   hl.dsp.focus({ workspace = i }))
    hl.bind(shift(code), hl.dsp.window.move({ workspace = i }))
end
hl.bind(key("mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(key("mouse_up"),   hl.dsp.focus({ workspace = "e-1" }))

-- Souris : SUPER + clic gauche = déplacer, clic droit = redimensionner
hl.bind(key("mouse:272"), hl.dsp.window.drag(),   { mouse = true })
hl.bind(key("mouse:273"), hl.dsp.window.resize(), { mouse = true })

-- Touches multimédia (fonctionnent écran verrouillé, se répètent si maintenues)
local media = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), media)
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      media)
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   media)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   media)
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

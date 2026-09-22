-- Voir https://wiki.hypr.land/Configuring/Monitors/
local monitors = machine.monitors or {
    { output = "", mode = "preferred", position = "auto", scale = 1 },
}

for _, m in ipairs(monitors) do
    hl.monitor(m)
end

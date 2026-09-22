---@module 'hl'
-- Point d'entrée : détecte la machine, puis charge les modules dans l'ordre.
-- Chaque module est dans conf/, la config propre à une machine dans hosts/<hostname>.lua

local DIR = os.getenv("HOME") .. "/.config/hypr/"

local function exists(path)
    local f = io.open(path)
    if f then f:close() return true end
    return false
end

local function hostname()
    local f = io.open("/etc/hostname")
    local h = f and f:read("*l") or "default"
    if f then f:close() end
    return h
end

-- Valeurs par défaut, surchargées par hosts/<hostname>.lua
-- (variable globale : les modules la lisent)
machine = {
    name        = hostname(),
    gpu         = "intel",   -- "intel" | "nvidia" : GPU qui fait le rendu de Hyprland
    drm_devices = nil,       -- ex. "/dev/dri/intel-igpu:/dev/dri/nvidia-dgpu" (AQ_DRM_DEVICES)
    monitors    = nil,       -- liste de hl.monitor ; nil = écran(s) en auto
}

local host_file = DIR .. "hosts/" .. machine.name .. ".lua"
if exists(host_file) then
    for k, v in pairs(dofile(host_file)) do machine[k] = v end
end

for _, module in ipairs({ "env", "monitors", "input", "look", "binds", "rules", "autostart" }) do
    dofile(DIR .. "conf/" .. module .. ".lua")
end

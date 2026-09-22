hl.env("XDG_SESSION_TYPE", "wayland")

if machine.gpu == "nvidia" then
    hl.env("LIBVA_DRIVER_NAME", "nvidia")
    hl.env("GBM_BACKEND", "nvidia-drm")
    hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
    -- Curseurs matériels cassés avec NVIDIA ; inutile (et plus lent) sur Intel
    hl.config({ cursor = { no_hardware_cursors = true } })
else
    hl.config({ cursor = { no_hardware_cursors = false } })
end

-- Choix des GPU utilisés par Hyprland (le premier fait le rendu)
if machine.drm_devices then
    hl.env("AQ_DRM_DEVICES", machine.drm_devices)
end

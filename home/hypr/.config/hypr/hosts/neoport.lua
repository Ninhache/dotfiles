-- ThinkPad P51 : Intel HD 630 (affichage) + Quadro M1200 (offload via prime-run)
return {
    -- Passer à "nvidia" réactive les variables d'env NVIDIA (voir conf/env.lua).
    -- Penser aussi à mkinitcpio (étape 5) : les deux vont ensemble.
    gpu = "intel",

    -- Ports vidéo externes câblés sur la Quadro (card0-DP-3/4/5), écran interne sur l'Intel.
    -- Le multi-GPU par défaut de Hyprland fonctionne (testé 09/2026) : pas besoin d'AQ_DRM_DEVICES.
    -- Si besoin un jour : règle udev (liens /dev/dri/intel-igpu, nvidia-dgpu) +
    -- drm_devices = "/dev/dri/intel-igpu:/dev/dri/nvidia-dgpu"
    drm_devices = nil,

    monitors = {
        { output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 },
        -- Tout autre écran : résolution préférée, placé à droite de l'écran interne
        { output = "",      mode = "preferred",    position = "auto-right", scale = 1 },
    },
}

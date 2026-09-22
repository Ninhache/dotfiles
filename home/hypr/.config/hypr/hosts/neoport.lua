-- ThinkPad P51 : Intel HD 630 (affichage) + Quadro M1200 (offload via prime-run)
return {
    -- Passer à "nvidia" réactive les variables d'env NVIDIA (voir conf/env.lua).
    -- Penser aussi à mkinitcpio (étape 5) : les deux vont ensemble.
    gpu = "intel",

    -- À remplir à l'étape 4 si le 2e écran est câblé sur la Quadro.
    drm_devices = nil,

    monitors = {
        { output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 },
        -- Tout autre écran : résolution préférée, placé à droite de l'écran interne
        { output = "",      mode = "preferred",    position = "auto-right", scale = 1 },
    },
}

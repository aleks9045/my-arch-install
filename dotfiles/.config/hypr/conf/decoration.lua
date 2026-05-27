hl.config({
    decoration = {
        rounding = 5,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        fullscreen_opacity = 1.0,

        blur = {
            enabled = true,
            size = 3,
            passes = 3,
            ignore_opacity = true,
            new_optimizations = true,
            xray = false,
            noise = 0.01,
            contrast = 0.9,
            brightness = 0.9,
            vibrancy = 0.2,
            vibrancy_darkness = 0.0,
            special = true,
        },

        dim_inactive = true,
        dim_strength = 0.1,
        dim_special = 0.2,
    },
})

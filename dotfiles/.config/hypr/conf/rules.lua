local floating = {
    "pavucontrol",
    "blueman-manager",
    "nm-connection-editor",
    "nwg-look",
    "qt5ct",
    "qt6ct",
    "wdisplays"
}

for _, class in ipairs(floating) do
    hl.window_rule({
        match = {
            class = "^(" .. class .. ")$"
        },

        float = true
    })
end

hl.window_rule({
    match = {
        title = "^(Картинка в картинке)$"
    },
    
    float = true,
    pin = true
})

hl.window_rule({
    match = {
        class = "^(hyprpolkitagent)$"
    },

    float = true,
    pin = true
})

hl.window_rule({
    match = {
        class = "^(kitty)$"
    },

    opacity = "0.92 0.92"
})

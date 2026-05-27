-- =========================================================
-- TERMINAL / APPS
-- =========================================================

hl.bind(
    "SUPER + code:36", -- Enter
    hl.dsp.exec_cmd("kitty")
)

hl.bind(
    "SUPER + code:56", -- B
    hl.dsp.exec_cmd("firefox")
)

hl.bind(
    "SUPER + code:41", -- F
    hl.dsp.exec_cmd("nautilus")
)

hl.bind(
    "SUPER + code:40", -- D
    hl.dsp.exec_cmd("fuzzel")
)

hl.bind(
    "SUPER + SHIFT + code:26", -- E
    hl.dsp.exec_cmd("qs -c noctalia-shell ipc call sessionMenu toggle")
)

-- =========================================================
-- WINDOW MANAGEMENT
-- =========================================================

hl.bind(
    "SUPER + code:24", -- Q
    hl.dsp.window.close()
)

hl.bind(
    "SUPER + code:25", -- W
    hl.dsp.window.close()
)

hl.bind(
    "SUPER + code:58", -- M
    hl.dsp.exit()
)

hl.bind(
    "SUPER + code:55", -- V
    hl.dsp.window.float({
        action = "toggle"
    })
)

hl.bind(
    "SUPER + code:44", -- J
    hl.dsp.layout("togglesplit")
)

hl.bind(
    "SUPER + code:33", -- P
    hl.dsp.window.pseudo()
)

-- =========================================================
-- FULLSCREEN
-- =========================================================

hl.bind(
    "SUPER + F11",
    hl.dsp.window.fullscreen()
)

hl.bind(
    "SUPER + F12",
    hl.dsp.window.fullscreen({
        mode = 1
    })
)

-- =========================================================
-- FOCUS
-- =========================================================

hl.bind(
    "SUPER + left",
    hl.dsp.focus({
        direction = "l"
    })
)

hl.bind(
    "SUPER + right",
    hl.dsp.focus({
        direction = "r"
    })
)

hl.bind(
    "SUPER + up",
    hl.dsp.focus({
        direction = "u"
    })
)

hl.bind(
    "SUPER + down",
    hl.dsp.focus({
        direction = "d"
    })
)

-- =========================================================
-- MOVE WINDOWS
-- =========================================================

hl.bind(
    "SUPER + SHIFT + left",
    hl.dsp.window.move({
        direction = "l"
    })
)

hl.bind(
    "SUPER + SHIFT + right",
    hl.dsp.window.move({
        direction = "r"
    })
)

hl.bind(
    "SUPER + SHIFT + up",
    hl.dsp.window.move({
        direction = "u"
    })
)

hl.bind(
    "SUPER + SHIFT + down",
    hl.dsp.window.move({
        direction = "d"
    })
)

-- =========================================================
-- RESIZE
-- =========================================================

-- =========================================================
-- RESIZE
-- =========================================================

hl.bind(
    "SUPER + CTRL + left",
    hl.dsp.layout("splitratio -0.1")
)

hl.bind(
    "SUPER + CTRL + right",
    hl.dsp.layout("splitratio 0.1")
)

-- =========================================================
-- WORKSPACES
-- =========================================================

for i = 1, 9 do
    hl.bind("SUPER + " .. i, function()
        hl.dispatch(hl.dsp.focus({
            workspace = tostring(i)
        }))
    end)

    hl.bind("SUPER + SHIFT + " .. i, function()
        hl.dispatch(hl.dsp.window.move({
            workspace = tostring(i),
            follow = true
        }))
    end)
end

-- =========================================================
-- CLIPBOARD UI
-- =========================================================

hl.bind(
    "SUPER + SHIFT + code:55", -- V
    hl.dsp.exec_cmd(
        [[qs -c noctalia-shell ipc call plugin:clipboard toggle]]
    )
)

-- =========================================================
-- SCREENSHOTS
-- =========================================================

hl.bind(
    "SUPER + SHIFT + code:39", -- S
    hl.dsp.exec_cmd(
        [[qs -c noctalia-shell ipc call plugin:screen-toolkit annotate]]
    )
)

hl.bind(
    "Print",
    hl.dsp.exec_cmd(
        [[qs -c noctalia-shell ipc call plugin:screen-toolkit annotateFullscreen]]
    )
)

-- =========================================================
-- AUDIO
-- =========================================================

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        [[qs -c noctalia-shell ipc call volume increase]]
    ),
    {
        repeating = true
    }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        [[qs -c noctalia-shell ipc call volume decrease]]
    ),
    {
        repeating = true
    }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd(
        [[qs -c noctalia-shell ipc call volume muteOutput]]
    ),
    {
        locked = true
    }
)

-- =========================================================
-- BRIGHTNESS
-- =========================================================

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd(
        "brightnessctl set 5%+"
    ),
    {
        repeating = true
    }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd(
        "brightnessctl set 5%-"
    ),
    {
        repeating = true
    }
)

-- =========================================================
-- MOUSE
-- =========================================================

hl.bind(
    "SUPER + mouse:272",
    hl.dsp.window.drag(),
    {
        mouse = true
    }
)

hl.bind(
    "SUPER + mouse:273",
    hl.dsp.window.resize(),
    {
        mouse = true
    }
)

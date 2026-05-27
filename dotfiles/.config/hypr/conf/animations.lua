-- =========================
-- 🎨 CURVES
-- =========================

hl.curve("linear", {
    type = "bezier",
    points = {
        {0, 0},
        {1, 1}
    }
})

hl.curve("wind", {
    type = "bezier",
    points = {
        {0.05, 0.9},
        {0.1, 1.05}
    }
})

hl.curve("winIn", {
    type = "bezier",
    points = {
        {0.1, 1.1},
        {0.1, 1.1}
    }
})

hl.curve("winOut", {
    type = "bezier",
    points = {
        {0.3, -0.3},
        {0, 1}
    }
})

hl.curve("smoothOut", {
    type = "bezier",
    points = {
        {0.36, 0},
        {0.66, -0.56}
    }
})

hl.curve("smoothIn", {
    type = "bezier",
    points = {
        {0.25, 1},
        {0.5, 1}
    }
})

hl.curve("overshot", {
    type = "bezier",
    points = {
        {0.33, 1},
        {0.68, 1.12}
    }
})

hl.curve("spring", {
    type = "spring",
    mass = 1,
    stiffness = 70,
    dampening = 15
})

-- =========================
-- 🪟 WINDOWS
-- =========================

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 2,
    bezier = "wind",
    style = "slide"
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 2,
    bezier = "winIn",
    style = "slide"
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 2,
    bezier = "winOut",
    style = "slide"
})

hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 2,
    bezier = "wind",
    style = "slide"
})

-- =========================
-- 🌫 FADE
-- =========================

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 2,
    bezier = "smoothOut"
})

hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 2,
    bezier = "smoothIn"
})

hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 2,
    bezier = "smoothOut"
})

-- =========================
-- 🧭 WORKSPACES
-- =========================

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 2,
    bezier = "overshot",
    style = "slidefade 20%"
})

-- =========================
-- ✨ SPECIAL WORKSPACE
-- =========================

hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 2,
    spring = "spring",
    style = "slidefadevert 20%"
})

-- =========================
-- 🪄 LAYERS
-- =========================

hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 2,
    bezier = "smoothOut",
    style = "slide"
})

hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 2,
    bezier = "smoothIn",
    style = "slide"
})

hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 2,
    bezier = "smoothOut",
    style = "slide"
})

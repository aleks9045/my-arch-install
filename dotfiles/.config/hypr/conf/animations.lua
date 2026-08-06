-- animation.lua

hl.curve("linear", {
	type = "bezier",
	points = {
		{ 0, 0 },
		{ 1, 1 },
	},
})

hl.curve("smooth", {
	type = "bezier",
	points = {
		{ 0.25, 0.1 },
		{ 0.25, 1 },
	},
})

hl.curve("fast", {
	type = "bezier",
	points = {
		{ 0.2, 0 },
		{ 0.1, 1 },
	},
})

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 1,
	bezier = "fast",
})

hl.animation({
	leaf = "windowsIn",
	enabled = false,
})

hl.animation({
	leaf = "windowsOut",
	enabled = false,
})

hl.animation({
	leaf = "windowsMove",
	enabled = true,
	speed = 1,
	bezier = "fast",
})

-- Fade

hl.animation({
	leaf = "fade",
	enabled = false,
})

hl.animation({
	leaf = "fadeIn",
	enabled = false,
})

hl.animation({
	leaf = "fadeOut",
	enabled = false,
})

-- Layers

hl.animation({
	leaf = "layers",
	enabled = true,
	speed = 1,
	bezier = "fast",
	style = "fade",
})

hl.animation({
	leaf = "layersIn",
	enabled = true,
	speed = 1,
	bezier = "fast",
	style = "fade",
})

hl.animation({
	leaf = "layersOut",
	enabled = true,
	speed = 1,
	bezier = "fast",
	style = "fade",
})

-- Workspaces

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 1,
	bezier = "fast",
	style = "slidefade 10%",
})

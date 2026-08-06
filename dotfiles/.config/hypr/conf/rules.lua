-- rules.lua

local floating = {
	"pavucontrol",
	"blueman-manager",
	"nm-connection-editor",
	"nwg-look",
	"qt5ct",
	"qt6ct",
	"wdisplays",
}

hl.window_rule({
	match = {
		class = ".*",
	},

	suppress_event = "maximize",
})

hl.window_rule({
	match = {
		float = true,
	},

	center = true,
	size = { "60%", "70%" },
})

for _, class in ipairs(floating) do
	hl.window_rule({
		match = {
			class = "^(" .. class .. ")$",
		},

		float = true,
	})
end

hl.window_rule({
	match = {
		class = "^(firefox)$",
	},

	workspace = "2",
})

hl.window_rule({
	match = {
		class = "^(firefox)$",
	},

	no_blur = true,
	opaque = true,
})

hl.window_rule({
	match = {
		title = "^(Картинка в картинке)$",
	},

	float = true,
	pin = true,
})

hl.window_rule({
	match = {
		class = "^(hyprpolkitagent)$",
	},

	float = true,
	pin = true,
})

hl.window_rule({
	match = {
		class = "^(galculator)$",
	},

	float = true,
	rounding = 5,
})

hl.layer_rule({
	name = "noctalia",

	match = {
		namespace = "^noctalia-background-.*$",
	},

	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

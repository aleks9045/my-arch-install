-- general.lua

local colors = dofile(os.getenv("HOME") .. "/.config/hypr/conf/colors.lua")

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 4,
		border_size = 2,
		col = {
			active_border = {
				colors = {
					colors.primary,
					colors.tertiary,
				},
				angle = 60,
			},

			inactive_border = colors.surface_dim,
		},
		layout = "dwindle",
		resize_on_border = true,
		extend_border_grab_area = 15,
		hover_icon_on_border = true,
	},
	dwindle = {
		preserve_split = true,
		force_split = 0,
		special_scale_factor = 0.8,
		split_width_multiplier = 1.0,
		use_active_for_splits = true,
		default_split_ratio = 1.0,
		smart_split = false,
		smart_resizing = true,
	},

	misc = {
		disable_splash_rendering = true,
		disable_hyprland_logo = true,
	},
})

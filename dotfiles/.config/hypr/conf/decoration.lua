-- decoraion.lua

hl.config({
	decoration = {
		rounding = 10,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 0.95,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 3,
			ignore_opacity = true,
			new_optimizations = true,
			xray = false,
		},

		dim_inactive = true,
		dim_strength = 0.1,
		dim_special = 0.2,
	},
})

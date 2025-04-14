local wezterm = require("wezterm")
local config = {}

local colorscheme = 'rose-pine'

local paint = {
	light = "dayfox",
	dark = colorscheme,
}

local function scheme_for_appearance(appearance)
	if appearance:find("Light") then
		return paint.light
	else
		return paint.dark
	end
end

wezterm.on("window-config-reloaded", function(window, _)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)

	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

config.font = wezterm.font({ family = "Iosevka Term", weight = "Regular" })
config.font_rules = {
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({ family = "Iosevka Term", weight = "Bold" }),
	},
}

config.font_size = 15.0
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.allow_square_glyphs_to_overflow_width = "Always"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.adjust_window_size_when_changing_font_size = false
config.custom_block_glyphs = false
config.native_macos_fullscreen_mode = true
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.max_fps = 60
config.force_reverse_video_cursor = false
config.use_ime = false
config.front_end = "WebGpu"
-- config.window_background_opacity = 0.8
-- config.macos_window_background_blur = 50

return config

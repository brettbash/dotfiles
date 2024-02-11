-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font("Fira Code")
config.font_size = 11.0
config.line_height = 1.75
config.color_scheme = "Tokyo Night"
-- config.window_background_opacity = 0.9
-- config.window_background_image = "backgrounds/synthwave.png"
-- config.window_background_image = "~/.config/wezterm/1.png"
-- config.window_background_image = "/.config/wezterm/1.png"
-- config.window_background_image = "/1.png"
config.hide_tab_bar_if_only_one_tab = true
-- local dimmer = { brightness = 0.1 }
config.background = {
	{
		source = {
			File = "/backgrounds/synthwave.png",
		},
	},
}

return config

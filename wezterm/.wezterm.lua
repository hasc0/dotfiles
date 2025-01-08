local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- disable close window confirmation overlay
config.window_close_confirmation = "NeverPrompt"
if os.getenv("OS") == "Windows_NT" then
	config.keys = {
		{
			key = "w",
			mods = "CTRL|SHIFT",
			action = wezterm.action.CloseCurrentTab { confirm = false },
		},
	}
else
	config.keys = {
		{
			key = "w",
			mods = "CMD",
			action = wezterm.action.CloseCurrentTab { confirm = false },
		},
	}
end

-- windows only
if os.getenv("OS") == "Windows_NT" then
	config.default_prog = { "pwsh.exe" }
	config.max_fps = 144
	config.animation_fps = 144
end

-- font_size = 14 for macos, 12 for windows
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 12

-- classic tab bar config and opacity
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_max_width = 50
config.text_background_opacity = 0.75

-- window opacity
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.75

-- macos only
if os.getenv("OS") == "Darwin" then
	config.macos_window_background_blur = 8
end

-- experimenting with cursor
config.default_cursor_style = "SteadyUnderline"

-- initial window size
config.initial_rows = 36
config.initial_cols = 120

-- color configuration
config.colors = {
	foreground = "#CECDC3",
	background = "#100F0F",
	cursor_bg = "#CECDC3",
	cursor_border = "#CECDC3",
	cursor_fg = "#100F0F",
	selection_bg = "#282726",
	selection_fg = "#CECDC3",
	ansi = { "#100F0F", "#AF3029", "#66800B", "#AD8301", "#205EA6", "#5E409D", "#24837B", "#CECDC3" },
	brights = { "#575653", "#D14D41", "#879A39", "#D0A215", "#4385BE", "#8B7EC8", "#3AA99F", "#FFFCF0" },

	tab_bar = {
		-- does not apply when fancy tab bar is in use
		background = "#100F0F",

		active_tab = {
			bg_color = "#282726",
			fg_color = "#FFFCF0",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		inactive_tab = {
			bg_color = "#100F0F",
			fg_color = "#CECDC3",
		},

		inactive_tab_hover = {
			bg_color = "#282726",
			fg_color = "#FFFCF0",
			italic = true,
		},

		new_tab = {
			bg_color = "#100F0F",
			fg_color = "#CECDC3",
		},

		new_tab_hover = {
			bg_color = "#282726",
			fg_color = "#FFFCF0",
			italic = true,
		},
	},
}

return config

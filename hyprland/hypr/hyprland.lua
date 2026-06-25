----------------
--- Monitors ---
----------------

hl.monitor({
	output = "DP-3",
	mode = "1920x1080@144",
	position = "0x0",
	scale = "1"
})

hl.monitor({
	output = "DP-2",
	mode = "1920x1080@144",
	position = "1920x0",
	scale = "1"
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "960x-1080",
	scale = "1"
})

----------------
--- Programs ---
----------------

local menu = "rofi"
local terminal = "ghostty"
local fileManager = "thunar"

-----------------
--- Autostart ---
-----------------

hl.on("hyprland.start", function ()
	hl.exec_cmd("hyptctl dispatch workspace 1")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waybar")
	hl.exec_cmd("swaync")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("udiskie -t")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("systemctl --user start rclone-mount.service")
end)

-----------------------------
--- Environment Variables ---
-----------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

---------------------
--- Look and Feel ---
---------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,
		border_size = 2,

		col = {
			active_border = { colors = { "rgba(c5c9c5ff)", "rgba(957fb8ff)", angle = 45 } },
			inactive_border = "rgba(595959aa)",
		},

		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		rounding_power = 2,

		active_opacity= 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	group = {
		col = {
			border_active = { colors = { "rgba(c5c9c5ff)", "rgba(957fb8ff)", angle = 45 } },
			border_inactive = "rgba(595959aa)",
			border_locked_active = { colors = { "rgba(c5c9c5ff)", "rgba(ffa066ff)", angle = 45 } },
			border_locked_inactive = "rgba(595959aa)",
		},

		groupbar = {
			font_family = "JetBrains Mono Nerd Font",
			font_size = 14,
			text_color = "rgba(ffffffff)",
			indicator_height = 0,
			gradients = true,
			height = 20,
			gaps_out = 4,
			gradient_rounding = 5,

			col = {
				active = "rgba(595959ee)",
				inactive = "rgba(595959aa)",
				locked_active = "rgba(595959ee)",
				locked_inactive = "rgba(595959aa)",
			},
		},
	},

	animations = {
		enabled = true,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1.0} } })
hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "almostLinear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
})

-------------
--- Input ---
-------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0,
		accel_profile = "flat",
	},
})

hl.device({
	name = "logitech-usb-receiver",
	sensitivity = 0.0,
})

-------------------
--- Keybindings ---
-------------------

local mainMod = "SUPER"

-- Basic Keybinds
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu .. " -show drun"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + H", hl.dsp.group.next())
hl.bind(mainMod .. " + L", hl.dsp.group.lock())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Change Focused Window
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move Current Window to a Different Position
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Switch Workspace and Move Focused Window
for i = 1, 10 do
    local key = i % 10 -- 10 Maps to 0 Key
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/Resize Windows with Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media Controls (Requires playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/$(date +%m-%d-%Y_%s.png)"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("grim -g \"$(slurp -o)\" ~/Pictures/Screenshots/$(date +%m-%d-%Y_%s.png)"))
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%m-%d-%Y_%s.png)"))

------------------------------
--- Windows and Workspaces ---
------------------------------

hl.workspace_rule({ workspace = "name:1", monitor = "DP-3" })
hl.workspace_rule({ workspace = "name:2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "name:3", monitor = "HDMI-A-1" })

hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true })
hl.window_rule({ match = { class = "^(nm-connection-editor)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })

-- Ignore Maximize Requests from Apps
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Fix Some Dragging Issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Background Blur for Waybar
hl.layer_rule({ match = { namespace = "waybar" }, blur = true, ignore_alpha = 0.5 })

-- Background Blur for Rofi
hl.layer_rule({ match = { namespace = "rofi" }, blur = true, ignore_alpha = 0.5 })

-- Background Blur for SwayNC
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0.5 })

--------------
--- Nvidia ---
--------------

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")


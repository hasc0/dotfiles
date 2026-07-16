hl.monitor({
	output = "DP-3",
	mode = "1920x1080@144",
	position =  "0x0",
	scale = "1"
})

hl.monitor({
	output = "DP-2",
	disabled = true
})

hl.monitor({
	output = "HDMI-A-1",
	disabled = true
})

hl.on("hyprland.start", function ()
	hl.exec_cmd("regreet; hyprctl dispatch 'hl.dsp.exit()'")
end)

hl.config({
	input = {
		sensitivity = 0,
		accel_profile = "flat",
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		disable_hyprland_guiutils_check = true,
	},
})


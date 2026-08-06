-- autostart.lua

hl.on("hyprland.start", function()
	hl.exec_cmd("qs -c noctalia-shell")
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
	hl.exec_cmd("imwheel")
	hl.exec_cmd("alacritty")
	--	hl.exec_cmd("sotavpn")
	hl.exec_cmd("firefox")
end)

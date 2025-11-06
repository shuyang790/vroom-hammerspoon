ClipboardToolOn = false

-- Clipboard Tool (text only)
if ClipboardToolOn and hs.spoons.isInstalled("ClipboardTool") then
	clipboardTool = hs.loadSpoon("ClipboardTool")
	if hs.spoons.isLoaded("ClipboardTool") then
		clipboardTool.paste_on_select = true
		clipboardTool.hist_size = 200
		clipboardTool:bindHotkeys({
			show_clipboard = { { "cmd", "shift" }, "V" },
			toggle_clipboard = { { "cmd", "shift" }, "V" },
		})
		clipboardTool:start()
	end
else
	hs.alert.show("Spoon ClipboardTool not installed!")
end

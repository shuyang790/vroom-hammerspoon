local clipboardToolEnabled = false

-- Clipboard Tool (text only)
if clipboardToolEnabled then
	if hs.spoons.isInstalled("ClipboardTool") then
		local clipboardTool = hs.loadSpoon("ClipboardTool")
		if hs.spoons.isLoaded("ClipboardTool") then
			clipboardTool.paste_on_select = true
			clipboardTool.hist_size = 200
			clipboardTool:bindHotkeys({
				toggle_clipboard = { { "cmd", "shift" }, "V" },
			})
			clipboardTool:start()
		end
	else
		hs.alert.show("Spoon ClipboardTool not installed!")
	end
end

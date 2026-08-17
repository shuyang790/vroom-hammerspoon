-- Application Switch

--------------------------------------------------------
-- Window Hints
hs.hotkey.bind({ "ctrl", "alt" }, "E", function()
	hs.hints.hintChars = {
		"E",
		"D",
		"C",
		"R",
		"F",
		"V",
		"Y",
		"H",
		"N",
		"U",
		"J",
		"M",
		"A",
		"S",
		"K",
		"L",
	}
	hs.hints.showTitleThresh = 10
	hs.hints.style = "vimperator"
	hs.hints.windowHints(hs.window.filter.new():getWindows())
end)
--------------------------------------------------------

--------------------------------------------------------
local function switchToAppByName(name)
	return function()
		if not hs.application.launchOrFocus(name) then
			hs.alert.show("Vroom cannot launch " .. name .. " :(")
		end
	end
end

local function switchToAppByBundleID(bundleID)
	return function()
		if not hs.application.launchOrFocusByBundleID(bundleID) then
			hs.alert.show("Vroom cannot launch " .. bundleID .. " :(")
		end
	end
end

local appShortcuts = {
	{ key = "A", bundleID = "com.microsoft.VSCode" },
	{ key = "B", bundleID = "com.apple.Safari" },
	{ key = "C", name = "Google Calendar" },
	{ key = "E", bundleID = "net.shinyfrog.bear" },
	{ key = "F", bundleID = "org.mozilla.firefox" },
	{ key = "G", bundleID = "com.google.Chrome" },
	{ key = "H", bundleID = "com.culturedcode.ThingsMac" },
	{ key = "M", name = "Gmail" },
	{ key = "N", bundleID = "com.apple.Notes" },
	{ key = "O", bundleID = "md.obsidian" },
	{ key = "P", bundleID = "com.apple.Music" },
	{ key = "R", bundleID = "com.apple.reminders" },
	{ key = "T", bundleID = "com.github.wez.wezterm" },
	{ key = "W", bundleID = "com.tencent.xinWeChat" },
	{ key = "X", bundleID = "com.openai.codex" },
	{ key = "Y", bundleID = "com.mitchellh.ghostty" },
	{ key = "Z", bundleID = "us.zoom.xos" },
}

for _, shortcut in ipairs(appShortcuts) do
	local action = shortcut.bundleID and switchToAppByBundleID(shortcut.bundleID)
		or switchToAppByName(shortcut.name)
	hs.hotkey.bind({ "ctrl", "shift" }, shortcut.key, action)
end

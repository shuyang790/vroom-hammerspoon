local ghosttyBundleID = "com.mitchellh.ghostty"
local tmuxTitlePrefix = "tmux:"

local function ghosttySmartAction(ghosttyAction, tmuxAction, label)
	local script = string.format(
		[[
tell application "Ghostty"
	if not frontmost then return false
	set targetWindow to front window
	set targetTab to selected tab of targetWindow
	set targetTerminal to focused terminal of targetTab
	set terminalName to name of targetTerminal

	if (count of terminals of targetTab) is 1 and terminalName begins with "%s" then
		return perform action "%s" on targetTerminal
	else
		return perform action "%s" on targetTerminal
	end if
end tell
]],
		tmuxTitlePrefix,
		tmuxAction,
		ghosttyAction
	)

	local ok, result, raw = hs.osascript.applescript(script)
	if not ok then
		hs.alert.show("Ghostty " .. label .. " failed")
		print("Ghostty " .. label .. " failed: " .. tostring(raw or result))
	end
end

local function ghosttySmartZoom()
	ghosttySmartAction("toggle_split_zoom", "esc:[5;30012~", "smart zoom")
end

local function ghosttySmartSplitRight()
	ghosttySmartAction("new_split:right", "esc:[5;30013~", "smart split right")
end

local function ghosttySmartSplitDown()
	ghosttySmartAction("new_split:down", "esc:[5;30014~", "smart split down")
end

local smartDigitActions = {
	{ key = "0", ghosttyAction = "reset_font_size", tmuxAction = "esc:[5;30020~" },
	{ key = "1", ghosttyAction = "goto_tab:1", tmuxAction = "esc:[5;30021~" },
	{ key = "2", ghosttyAction = "goto_tab:2", tmuxAction = "esc:[5;30022~" },
	{ key = "3", ghosttyAction = "goto_tab:3", tmuxAction = "esc:[5;30023~" },
	{ key = "4", ghosttyAction = "goto_tab:4", tmuxAction = "esc:[5;30024~" },
	{ key = "5", ghosttyAction = "goto_tab:5", tmuxAction = "esc:[5;30025~" },
	{ key = "6", ghosttyAction = "goto_tab:6", tmuxAction = "esc:[5;30026~" },
	{ key = "7", ghosttyAction = "goto_tab:7", tmuxAction = "esc:[5;30027~" },
	{ key = "8", ghosttyAction = "goto_tab:8", tmuxAction = "esc:[5;30028~" },
	{ key = "9", ghosttyAction = "last_tab", tmuxAction = "esc:[5;30029~" },
}

local function ghosttyIsFrontmost()
	local app = hs.application.frontmostApplication()
	return app and app:bundleID() == ghosttyBundleID
end

local function updateGhosttySmartHotkeys()
	if ghosttyIsFrontmost() then
		for _, hotkey in ipairs(_GhosttySmartHotkeys) do
			hotkey:enable()
		end
	else
		for _, hotkey in ipairs(_GhosttySmartHotkeys) do
			hotkey:disable()
		end
	end
end

_GhosttySmartHotkeys = {
	hs.hotkey.new({ "cmd", "shift" }, "return", ghosttySmartZoom),
	hs.hotkey.new({ "cmd" }, "d", ghosttySmartSplitRight),
	hs.hotkey.new({ "cmd", "shift" }, "d", ghosttySmartSplitDown),
}

for _, action in ipairs(smartDigitActions) do
	table.insert(
		_GhosttySmartHotkeys,
		hs.hotkey.new({ "cmd" }, action.key, function()
			ghosttySmartAction(action.ghosttyAction, action.tmuxAction, "smart tab " .. action.key)
		end)
	)
end

_GhosttySmartWatcher = hs.application.watcher.new(function(_, eventType)
	if
		eventType == hs.application.watcher.activated
		or eventType == hs.application.watcher.deactivated
		or eventType == hs.application.watcher.launched
		or eventType == hs.application.watcher.terminated
	then
		updateGhosttySmartHotkeys()
	end
end):start()

updateGhosttySmartHotkeys()

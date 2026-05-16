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

require("hs.application")
require("modules.windowManagement")
require("modules.applicationSwitch")
require("modules.layoutManagement")
require("modules.ghostty")

--------------------------------------------------------
local hotkeyCheatsheet = [[
WINDOWS
⌃⌥ + arrows   Cycle 1/2 → 1/3 → 2/3
⌃⌥ + return   Fill screen
⌃⌥ + C        Center at 80%
⌃⌥ + U/I/J/K  Quarter screen
⌃⌥ + delete   Restore original frame
⌃⌥ + R        Resize mode (Tab for its help)
⌥ + Tab       Switch window in current Space

LAYOUTS
⌃⌥⌘ + P       Layout mode (R register, Y pair)
⌃⌥ + E        Window hints

APPS
⌃⇧ + A/B/C/E/F/G/H/M/N/O/P/R/T/W/X/Y/Z

SYSTEM
⌃⇧⌘ + Q       Lock screen
]]

hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "A", function()
	hs.alert.show(hotkeyCheatsheet, { textSize = 18, radius = 12 }, 10)
end)

--------------------------------------------------------
-- Reload Config
local function reloadConfig(files)
	local doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Hammerspoon: Config loaded")
--------------------------------------------------------

hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "Q", function()
	hs.caffeinate.lockScreen()
end)

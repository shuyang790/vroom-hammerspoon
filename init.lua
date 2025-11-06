require("hs.application")
require("modules.windowManagement")
require("modules.applicationSwitch")
require("modules.layoutManagement")
require("modules.clipboard")

--------------------------------------------------------
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "A", function()
	hs.alert.show("Hello! I am your help from Hammerspoon :)")
	hs.notify.new({ title = "Hammerspoon", informativeText = "Hello, my friend! :)" }):send()
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

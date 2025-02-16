require("hs.application")
require("windowManagement")
require("applicationSwitch")
require("layoutManagement")

clipboardToolOn = false

--------------------------------------------------------
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "A", function()
	hs.alert.show("Hello! My name is Vroom :)")
	hs.notify.new({ title = "Vroom", informativeText = "Hello, my friend! :)" }):send()
end)

--------------------------------------------------------
-- Reload Config
function reloadConfig(files)
	doReload = false
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
hs.alert.show("Vroom: Config loaded")
--------------------------------------------------------

--------------------------------------------------------
-- Spotify
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "S", function()
	if hs.spotify.isRunning() then
		hs.alert.show(
			"Track: "
				.. hs.spotify.getCurrentTrack()
				.. "\n"
				.. "Artist: "
				.. hs.spotify.getCurrentArtist()
				.. "\n"
				.. "Album: "
				.. hs.spotify.getCurrentAlbum()
		)
	end
end)
--------------------------------------------------------

hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "Q", function()
	hs.caffeinate.lockScreen()
end)

--------------------------------------------------------
-- Clipboard Tool (text only)
if clipboardToolOn and hs.spoons.isInstalled("ClipboardTool") then
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

--------------------------------------------------------
-- HSearch
-- if hs.spoons.isInstalled("HSearch") then
--   local hSearch = hs.loadSpoon("HSearch")
--   if hs.spoons.isLoaded("HSearch") then
--     hSearch:loadSources()
--     hs.hotkey.bind("alt", "space", function()
--       hSearch:toggleShow()
--     end)
--   end
-- else
--   hs.alert.show("Spoon HSearch not installed!")
-- end

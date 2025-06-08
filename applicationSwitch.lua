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
-- Template
function switchToAppByName(name)
	return function()
		local launch = hs.application.launchOrFocus(name)
		if not launch then
			hs.alert.show("Vroom cannot launch " .. name .. " :(")
		end
	end
end

function switchToAppByBundleID(bundleID)
	return function()
		local launch = hs.application.launchOrFocusByBundleID(bundleID)
		if not launch then
			hs.alert.show("Vroom cannot launch " .. bundleID .. " :(")
		end
	end
end
--------------------------------------------------------

-- Atom / VS Code
hs.hotkey.bind({ "ctrl", "shift" }, "A", switchToAppByName("Visual Studio Code"))

-- Browser
hs.hotkey.bind({ "ctrl", "shift" }, "B", switchToAppByName("Safari"))

-- Fantastical / Calendar
hs.hotkey.bind({ "ctrl", "shift" }, "C", switchToAppByName("Calendar"))

-- Evernote / Notes
hs.hotkey.bind({ "ctrl", "shift" }, "E", switchToAppByName("Notes"))

function chrome_switch_to(ppl)
	return function()
		hs.application.launchOrFocus("Google Chrome")
		local chrome = hs.appfinder.appFromName("Google Chrome")
		local str_menu_item
		if ppl == "Incognito" then
			str_menu_item = { "File", "New Incognito Window" }
		else
			str_menu_item = { "Profiles", ppl }
		end
		local menu_item = chrome:findMenuItem(str_menu_item)
		if menu_item then
			chrome:selectMenuItem(str_menu_item)
		end
	end
end

-- Chrome
hs.hotkey.bind(
	{ "ctrl", "shift" },
	"G",
	-- chrome_switch_to("Shuyang (Personal)")
	switchToAppByBundleID("com.google.chrome")
)

-- Firefox
hs.hotkey.bind({ "ctrl", "shift" }, "F", switchToAppByBundleID("org.mozilla.firefox"))

-- Email
hs.hotkey.bind({ "ctrl", "shift" }, "M", switchToAppByName("Mail"))

-- Notes
hs.hotkey.bind({ "ctrl", "shift" }, "N", switchToAppByName("Notes.app"))

-- Outlook
hs.hotkey.bind(
	{ "ctrl", "shift" },
	"O",
	switchToAppByBundleID("com.microsoft.Outlook")
	-- switchToAppByName("Outlook")
)

hs.hotkey.bind({ "ctrl", "shift" }, "P", switchToAppByName("Music.app"))

-- Spotify
hs.hotkey.bind({ "ctrl", "shift" }, "S", switchToAppByBundleID("com.spotify.client"))

-- iTerm
hs.hotkey.bind({ "ctrl", "shift" }, "T", switchToAppByBundleID("com.googlecode.iterm2"))

-- Vivaldi
hs.hotkey.bind({ "ctrl", "shift" }, "V", switchToAppByBundleID("com.vivaldi.Vivaldi"))

-- Wechat
hs.hotkey.bind({ "ctrl", "shift" }, "W", switchToAppByBundleID("com.tencent.xinWechat"))

hs.hotkey.bind({ "ctrl", "shift" }, "Y", switchToAppByName("Typora"))

-- Things 3
hs.hotkey.bind({ "ctrl", "shift" }, "H", switchToAppByName("Things3"))

-- Zoom
hs.hotkey.bind({ "ctrl", "shift" }, "Z", switchToAppByName("zoom.us"))
--------------------------------------------------------
-- Helper
function findApplicationBundleID(name)
	local apps = hs.application.runningApplications()
	for k, v in pairs(apps) do
		if string.find(v:name(), name) ~= nil then
			hs.alert(v:bundleID(), 10)
		end
	end
end

-- Window Management
--   which includes
--   - window movement CTRL + ALT + CMD + H/J/K/L
--   - window size adjustment CTRL + SHIFT + ALT + H/J/K/L
--   - window full screen CTRL + ALT + RETURN
--   - window size cycle (1/2, 1/3, 2/3) CTRL + ALT + Left/Right/Up/Down
--   - window quarter screen CTRL + ALT + U/I/J/K
--   - window switch within Space ALT + TAB

hs.window.animationDuration = 0

local function loadSpoon(name)
	if not hs.spoons.isLoaded(name) then
		hs.loadSpoon(name)
	end
end

loadSpoon("ModalMgr")
loadSpoon("WinWin")

local windowCache = {}

local function saveWindowState(win, frame)
	local id = win:id()
	if windowCache[id] == nil then
		windowCache[id] = {
			x = frame.x,
			y = frame.y,
			w = frame.w,
			h = frame.h,
		}
	end
end

local function withFocusedWindow(action)
	return function()
		local win = hs.window.focusedWindow()
		if not win then
			hs.alert.show("No focused window")
			return
		end
		action(win)
	end
end

----------------------------------------------------------------------------------------------------
-- resizeM modal environment
if spoon.ModalMgr and spoon.WinWin then
	spoon.ModalMgr:new("resizeM")
	local cmodal = spoon.ModalMgr.modal_list["resizeM"]
	cmodal:bind("", "escape", "Deactivate resizeM", function()
		spoon.ModalMgr:deactivate({ "resizeM" })
	end)
	cmodal:bind("", "return", "Whole screen without Fullscreen", withFocusedWindow(function(win)
		local f = win:frame()
		local screen = win:screen()
		local max = screen:frame()

		saveWindowState(win, f)
		f.x = max.x
		f.y = max.y
		f.w = max.w
		f.h = max.h
		win:setFrame(f, 0)
	end))
	cmodal:bind("", "Q", "Deactivate resizeM", function()
		spoon.ModalMgr:deactivate({ "resizeM" })
	end)
	cmodal:bind("", "tab", "Toggle Cheatsheet", function()
		spoon.ModalMgr:toggleCheatsheet()
	end)
	cmodal:bind(
		"",
		"A",
		"Move Leftward",
		function()
			spoon.WinWin:stepMove("left")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("left")
		end
	)
	cmodal:bind(
		"",
		"D",
		"Move Rightward",
		function()
			spoon.WinWin:stepMove("right")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("right")
		end
	)
	cmodal:bind(
		"",
		"W",
		"Move Upward",
		function()
			spoon.WinWin:stepMove("up")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("up")
		end
	)
	cmodal:bind(
		"",
		"S",
		"Move Downward",
		function()
			spoon.WinWin:stepMove("down")
		end,
		nil,
		function()
			spoon.WinWin:stepMove("down")
		end
	)
	cmodal:bind("", "H", "Lefthalf of Screen", function()
		spoon.WinWin:moveAndResize("halfleft")
	end)
	cmodal:bind("", "L", "Righthalf of Screen", function()
		spoon.WinWin:moveAndResize("halfright")
	end)
	cmodal:bind("", "K", "Uphalf of Screen", function()
		spoon.WinWin:moveAndResize("halfup")
	end)
	cmodal:bind("", "J", "Downhalf of Screen", function()
		spoon.WinWin:moveAndResize("halfdown")
	end)
	cmodal:bind("", "Y", "NorthWest Corner", function()
		spoon.WinWin:moveAndResize("cornerNW")
	end)
	cmodal:bind("", "O", "NorthEast Corner", function()
		spoon.WinWin:moveAndResize("cornerNE")
	end)
	cmodal:bind("", "U", "SouthWest Corner", function()
		spoon.WinWin:moveAndResize("cornerSW")
	end)
	cmodal:bind("", "I", "SouthEast Corner", function()
		spoon.WinWin:moveAndResize("cornerSE")
	end)
	cmodal:bind("", "F", "Fullscreen", function()
		spoon.WinWin:moveAndResize("fullscreen")
	end)
	cmodal:bind("", "C", "Center Window", function()
		spoon.WinWin:moveAndResize("center")
	end)
	cmodal:bind(
		"",
		"=",
		"Stretch Outward",
		function()
			spoon.WinWin:moveAndResize("expand")
		end,
		nil,
		function()
			spoon.WinWin:moveAndResize("expand")
		end
	)
	cmodal:bind(
		"",
		"-",
		"Shrink Inward",
		function()
			spoon.WinWin:moveAndResize("shrink")
		end,
		nil,
		function()
			spoon.WinWin:moveAndResize("shrink")
		end
	)
	cmodal:bind(
		"shift",
		"H",
		"Move Leftward",
		function()
			spoon.WinWin:stepResize("left")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("left")
		end
	)
	cmodal:bind(
		"shift",
		"L",
		"Move Rightward",
		function()
			spoon.WinWin:stepResize("right")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("right")
		end
	)
	cmodal:bind(
		"shift",
		"K",
		"Move Upward",
		function()
			spoon.WinWin:stepResize("up")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("up")
		end
	)
	cmodal:bind(
		"shift",
		"J",
		"Move Downward",
		function()
			spoon.WinWin:stepResize("down")
		end,
		nil,
		function()
			spoon.WinWin:stepResize("down")
		end
	)
	cmodal:bind("", "left", "Move to Left Monitor", function()
		spoon.WinWin:moveToScreen("left")
	end)
	cmodal:bind("", "right", "Move to Right Monitor", function()
		spoon.WinWin:moveToScreen("right")
	end)
	cmodal:bind("", "up", "Move to Above Monitor", function()
		spoon.WinWin:moveToScreen("up")
	end)
	cmodal:bind("", "down", "Move to Below Monitor", function()
		spoon.WinWin:moveToScreen("down")
	end)
	cmodal:bind("", "space", "Move to Next Monitor", function()
		spoon.WinWin:moveToScreen("next")
	end)
	cmodal:bind("", "[", "Undo Window Manipulation", function()
		spoon.WinWin:undo()
	end)
	cmodal:bind("", "]", "Redo Window Manipulation", function()
		spoon.WinWin:redo()
	end)
	cmodal:bind("", "`", "Center Cursor", function()
		spoon.WinWin:centerCursor()
	end)

	-- Register resizeM with modal supervisor
	hs.hotkey.bind({ "ctrl", "alt" }, "R", function()
		-- Deactivate some modal environments or not before activating a new one
		spoon.ModalMgr:deactivateAll()
		-- Show an status indicator so we know we're in some modal environment now
		spoon.ModalMgr:activate({ "resizeM" }, "#B22222")
	end)
end
--------------------------------------------------------
-- Window Layout: Resume previous
hs.hotkey.bind({ "alt", "ctrl" }, "delete", withFocusedWindow(function(win)
	local id = win:id()
	if windowCache[id] ~= nil then
		win:setFrame(windowCache[id], 0)
		windowCache[id] = nil
	else
		hs.alert.show("Window not in cache!")
	end
end))
--------------------------------------------------------

--------------------------------------------------------
-- Window Switch within the Space
local switcherInSpace = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter({})) -- include minimized/hidden windows, current Space only

hs.hotkey.bind("alt", "tab", function()
	switcherInSpace:next()
end)

--------------------------------------------------------
-- Window Movement
hs.hotkey.bind({ "ctrl", "cmd", "alt" }, "H", withFocusedWindow(function(win)
	local f = win:frame()

	f.x = f.x - 30
	win:setFrame(f)
end))

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "K", withFocusedWindow(function(win)
	local f = win:frame()

	f.y = f.y - 30
	win:setFrame(f)
end))

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "L", withFocusedWindow(function(win)
	local f = win:frame()

	f.x = f.x + 30
	win:setFrame(f)
end))

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "J", withFocusedWindow(function(win)
	local f = win:frame()

	f.y = f.y + 30
	win:setFrame(f)
end))
--------------------------------------------------------

--------------------------------------------------------
-- Window Size Adjustment
hs.hotkey.bind({ "shift", "alt", "ctrl" }, "H", withFocusedWindow(function(win)
	local f = win:frame()

	f.w = f.w - 30
	win:setFrame(f)
end))

hs.hotkey.bind({ "shift", "alt", "ctrl" }, "K", withFocusedWindow(function(win)
	local f = win:frame()

	f.h = f.h - 30
	win:setFrame(f)
end))

hs.hotkey.bind({ "shift", "alt", "ctrl" }, "L", withFocusedWindow(function(win)
	local f = win:frame()

	f.w = f.w + 30
	win:setFrame(f)
end))

hs.hotkey.bind({ "shift", "alt", "ctrl" }, "J", withFocusedWindow(function(win)
	local f = win:frame()

	f.h = f.h + 30
	win:setFrame(f)
end))
--------------------------------------------------------

--------------------------------------------------------
-- Window Layout: Full Screen
hs.hotkey.bind({ "alt", "ctrl" }, "return", withFocusedWindow(function(win)
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	saveWindowState(win, f)
	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h
	win:setFrame(f, 0)
end))

--------------------------------------------------------
-- Window Layout: Cycle through 1/2, 1/3, and 2/3 of the screen
local windowSizeCycle = { 1 / 2, 1 / 3, 2 / 3 }
local frameTolerance = 2

local function framesClose(actual, expected)
	return math.abs(actual - expected) <= frameTolerance
end

local function nextWindowRatio(f, max, direction)
	local isHorizontal = direction == "left" or direction == "right"
	local isAligned

	if direction == "left" then
		isAligned = framesClose(f.x, max.x)
			and framesClose(f.y, max.y)
			and framesClose(f.h, max.h)
	elseif direction == "right" then
		isAligned = framesClose(f.x + f.w, max.x + max.w)
			and framesClose(f.y, max.y)
			and framesClose(f.h, max.h)
	elseif direction == "up" then
		isAligned = framesClose(f.y, max.y)
			and framesClose(f.x, max.x)
			and framesClose(f.w, max.w)
	else
		isAligned = framesClose(f.y + f.h, max.y + max.h)
			and framesClose(f.x, max.x)
			and framesClose(f.w, max.w)
	end

	if isAligned then
		local currentSize = isHorizontal and f.w or f.h
		local availableSize = isHorizontal and max.w or max.h

		for index, ratio in ipairs(windowSizeCycle) do
			if framesClose(currentSize, availableSize * ratio) then
				return windowSizeCycle[(index % #windowSizeCycle) + 1]
			end
		end
	end

	return windowSizeCycle[1]
end

local function cycleWindowSize(win, direction)
	local f = win:frame()
	local max = win:screen():frame()
	local ratio = nextWindowRatio(f, max, direction)
	saveWindowState(win, f)

	if direction == "left" or direction == "right" then
		f.y = max.y
		f.w = max.w * ratio
		f.h = max.h
		f.x = direction == "left" and max.x or max.x + max.w - f.w
	else
		f.x = max.x
		f.y = direction == "up" and max.y or max.y + max.h - (max.h * ratio)
		f.w = max.w
		f.h = max.h * ratio
	end

	win:setFrame(f, 0)
end

hs.hotkey.bind({ "alt", "ctrl" }, "Left", withFocusedWindow(function(win)
	cycleWindowSize(win, "left")
end))

hs.hotkey.bind({ "alt", "ctrl" }, "Right", withFocusedWindow(function(win)
	cycleWindowSize(win, "right")
end))

hs.hotkey.bind({ "alt", "ctrl" }, "Up", withFocusedWindow(function(win)
	cycleWindowSize(win, "up")
end))

hs.hotkey.bind({ "alt", "ctrl" }, "Down", withFocusedWindow(function(win)
	cycleWindowSize(win, "down")
end))

hs.hotkey.bind({ "alt", "ctrl" }, "C", withFocusedWindow(function(win)
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	saveWindowState(win, f)

	f.x = max.x + (max.w / 10)
	f.y = max.y + (max.h / 10)
	f.w = max.w * 0.8
	f.h = max.h * 0.8
	win:setFrame(f, 0)
end))
--------------------------------------------------------

--------------------------------------------------------
-- Window Layout: Quater Screen
hs.hotkey.bind({ "alt", "ctrl" }, "I", withFocusedWindow(function(win)
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	saveWindowState(win, f)

	f.x = max.x + (max.w / 2)
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h / 2
	win:setFrame(f, 0)
end))

hs.hotkey.bind({ "alt", "ctrl" }, "U", withFocusedWindow(function(win)
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	saveWindowState(win, f)

	f.x = max.x
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h / 2
	win:setFrame(f, 0)
end))

hs.hotkey.bind({ "alt", "ctrl" }, "K", withFocusedWindow(function(win)
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	saveWindowState(win, f)

	f.x = max.x + (max.w / 2)
	f.y = max.y + (max.h / 2)
	f.w = max.w / 2
	f.h = max.h / 2
	win:setFrame(f, 0)
end))

hs.hotkey.bind({ "alt", "ctrl" }, "J", withFocusedWindow(function(win)
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	saveWindowState(win, f)

	f.x = max.x
	f.y = max.y + (max.h / 2)
	f.w = max.w / 2
	f.h = max.h / 2
	win:setFrame(f, 0)
end))
--------------------------------------------------------

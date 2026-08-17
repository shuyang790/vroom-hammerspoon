local layoutModal = hs.hotkey.modal.new({ "cmd", "alt", "ctrl" }, "P")
local registeredWindowId

function layoutModal:entered()
	hs.alert.show("Layout mode: R to register, Y for side by side, Esc to exit")
end

layoutModal:bind("", "escape", function()
	hs.alert.closeAll()
	layoutModal:exit()
end)

layoutModal:bind("", "P", function()
	layoutModal:exit()
end)

-- Register the currently focused window as the left-side reference window.
layoutModal:bind("", "R", function()
	local win = hs.window.focusedWindow()
	if not win then
		hs.alert.closeAll()
		hs.alert.show("No focused window to register")
		layoutModal:exit()
		return
	end

	registeredWindowId = win:id()
	local app = win:application()
	local label = app and app:name() or win:title()
	hs.alert.closeAll()
	hs.alert.show("Registered window: " .. label)
	layoutModal:exit()
end)

-- Place the registered window on the left and the current window on the right.
layoutModal:bind("", "Y", function()
	local registeredWindow = registeredWindowId and hs.window.get(registeredWindowId)
	local currentWindow = hs.window.focusedWindow()

	if not registeredWindow then
		hs.alert.closeAll()
		hs.alert.show("Register a window first")
		layoutModal:exit()
		return
	end

	if not currentWindow or currentWindow:id() == registeredWindow:id() then
		hs.alert.closeAll()
		hs.alert.show("Focus a different window for the right side")
		layoutModal:exit()
		return
	end

	local screenFrame = currentWindow:screen():frame()
	local halfWidth = screenFrame.w / 2

	registeredWindow:setFrame({
		x = screenFrame.x,
		y = screenFrame.y,
		w = halfWidth,
		h = screenFrame.h,
	}, 0)
	currentWindow:setFrame({
		x = screenFrame.x + halfWidth,
		y = screenFrame.y,
		w = halfWidth,
		h = screenFrame.h,
	}, 0)

	hs.alert.closeAll()
	layoutModal:exit()
end)

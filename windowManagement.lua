-- Window Management
--   which includes
--   - window movement CTRL + ALT + CMD + H/J/K/L
--   - window size adjustment CTRL + SHIFT + ALT + H/J/K/L
--   - window full screen CTRL + ALT + RETURN
--   - window half screen CTRL + ALT + Left/Right/Up/Down/C
--   - window quarter screen CTRL + ALT + U/I/J/K 
--   - window switch within Space ALT + TAB
--   - (*) move to another space CTRL + ALT + Left/Right


--------------------------------------------------------
-- Helper: Save Window State
windowCache = {}
function saveWindowState(win, f)
  local id = win:id()
  if windowCache[id] == nil then
    windowCache[id] = {}
    windowCache[id]["x"] = f.x
    windowCache[id]["y"] = f.y
    windowCache[id]["w"] = f.w
    windowCache[id]["h"] = f.h
  end
end
--------------------------------------------------------

--------------------------------------------------------
-- Window Layout: Resume previous
hs.hotkey.bind({"alt", "ctrl"}, "delete", function()
  local win = hs.window.focusedWindow()
  local id = win:id()
  local f = win:frame()
  if windowCache[id] ~= nil then
    win:setFrame(windowCache[id], 0)
    windowCache[id] = nil
  else
    hs.alert.show("Window not in cache!")
  end
end)
--------------------------------------------------------

--------------------------------------------------------
-- Window Switch within the Space
switcherInSpace = hs.window.switcher.new(
  hs.window.filter.new()
    :setCurrentSpace(true)
    :setDefaultFilter{}
) -- include minimized/hidden windows, current Space only

hs.hotkey.bind('alt', 'tab', function()
  switcherInSpace:next()
end)

--------------------------------------------------------
-- Window Movement
hs.hotkey.bind({"ctrl", "cmd", "alt"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 30
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - 30
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 30
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + 30
  win:setFrame(f)
end)
--------------------------------------------------------

--------------------------------------------------------
-- Window Size Adjustment
hs.hotkey.bind({"shift", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w - 30
  win:setFrame(f)
end)

hs.hotkey.bind({"shift", "alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h - 30
  win:setFrame(f)
end)

hs.hotkey.bind({"shift", "alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.w = f.w + 30
  win:setFrame(f)
end)

hs.hotkey.bind({"shift", "alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.h = f.h + 30
  win:setFrame(f)
end)
--------------------------------------------------------

--------------------------------------------------------
-- Window Layout: Full Screen
hs.hotkey.bind({"alt", "ctrl"}, "return", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  saveWindowState(win, f)
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f, 0)
end)
--------------------------------------------------------

--------------------------------------------------------
-- Window Layout: Half Screen
hs.hotkey.bind({"alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  saveWindowState(win, f)

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  saveWindowState(win, f)

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"alt", "ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  saveWindowState(win, f)

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"alt", "ctrl"}, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  saveWindowState(win, f)

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"alt", "ctrl"}, "C", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  saveWindowState(win, f)

  f.x = max.x + (max.w / 10)
  f.y = max.y + (max.h / 10)
  f.w = max.w * 0.8
  f.h = max.h * 0.8
  win:setFrame(f, 0)
end)
--------------------------------------------------------

--------------------------------------------------------
-- Window Layout: Quater Screen
hs.hotkey.bind({"alt", "ctrl"}, "I", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  saveWindowState(win, f)

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"alt", "ctrl"}, "U", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  saveWindowState(win, f)

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  saveWindowState(win, f)

  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  saveWindowState(win, f)

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f, 0)
end)
--------------------------------------------------------

-- credit for
-- https://github.com/Hammerspoon/hammerspoon/issues/235
--
function moveWindowOneSpace(direction)
   local mouseOrigin = hs.mouse.getAbsolutePosition()
   local win = hs.window.focusedWindow()
   local clickPoint = win:zoomButtonRect()

   clickPoint.x = clickPoint.x + clickPoint.w + 5
   clickPoint.y = clickPoint.y + (clickPoint.h / 2)

   local mouseClickEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmousedown, clickPoint)
   mouseClickEvent:post()
   hs.timer.usleep(150000)

   local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, direction, true)
   nextSpaceDownEvent:post()
   hs.timer.usleep(150000)

   local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, direction, false)
   nextSpaceUpEvent:post()
   hs.timer.usleep(150000)

   local mouseReleaseEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmouseup, clickPoint)
   mouseReleaseEvent:post()
   hs.timer.usleep(150000)

   hs.mouse.setAbsolutePosition(mouseOrigin)
end

hk1 = hs.hotkey.bind({"cmd", "ctrl", "alt"}, "right",
   function() moveWindowOneSpace("right") end)
hk2 = hs.hotkey.bind({"cmd", "ctrl", "alt"}, "left",
   function() moveWindowOneSpace("left") end)

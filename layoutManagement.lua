modal = hs.hotkey.modal.new('cmd-alt-ctrl', 'P')

--------------------------------------------------------

function modal:entered()
  hs.alert'Layout mode: Enter'
end

function modal:exited()
  hs.alert'Layout mode: Exit'
end

modal:bind({'cmd', 'alt', 'ctrl'}, 'P', function()
  modal:exit()
end)

-- register browser
browserId = nil
modal:bind({'cmd', 'alt', 'ctrl'}, 'R', function()
  switchToAppByBundleID("com.vivaldi.Vivaldi")
  local w = hs.window.focusedWindow()
  -- hs.alert.show(w:title())
  if string.match(w:title(), "^.*- Vivaldi") then
    browserId = w:id()
    hs.alert.show('Browser window registered: ' .. browserId)
  end
end)

-- Side by side current window with browser
modal:bind({'cmd', 'alt', 'ctrl'}, 'Y', function()
  local browser = hs.window.get(browserId)
  local app = hs.window.focusedWindow()

  if browser and app then 
    hs.alert.show("Browser " .. browser:id() .. " and app " .. app:id())
    local max = browser:screen():frame()
    local fB = browser:frame()
    fB.x = max.x
    fB.y = max.y
    fB.w = max.w / 2
    fB.h = max.h
    browser:setFrame(fB, 0)

    local fI = app:frame()
    fI.x = max.x + (max.w / 2)
    fI.y = max.y
    fI.w = max.w / 2
    fI.h = max.h
    app:setFrame(fI, 0)
  end
  modal:exit()
end)


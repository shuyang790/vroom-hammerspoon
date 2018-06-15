modal = hs.hotkey.modal.new('shift-ctrl', 'K')

--------------------------------------------------------
-- -- Template
-- function switchToAppByName(name)
--   return function()
--     local launch = hs.application.launchOrFocus(name)
--     if not launch then
--       hs.alert.show("Vroom cannot launch " .. name .. " :(")
--     end
--   end
-- end
-- 
-- function switchToAppByBundleID(bundleID)
--   return function()
--     local launch = hs.application.launchOrFocusByBundleID(bundleID)
--     if not launch then
--       hs.alert.show("Vroom cannot launch " .. bundleID .. " :(")
--     end
--   end
-- end
--------------------------------------------------------

function modal:entered()
  hs.alert'More App mode: Enter'
end

function modal:exited()
  hs.alert'More App mode: Exit'
end

modal:bind({'shift', 'ctrl'}, 'K', function()
  modal:exit()
end)

modal:bind({'cmd', 'alt', 'ctrl'}, 'W', function()
  switchToAppByName("Wunderlist")
  modal:exit()
end)


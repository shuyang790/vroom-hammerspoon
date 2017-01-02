-- Application Switch


--------------------------------------------------------
-- iTerm
hs.hotkey.bind({"ctrl", "shift"}, "T", function()
  local launch = hs.application.launchOrFocus("iTerm")
  if not launch then
    hs.alert.show("Vroom cannot launch iTerm :(")
  end
end)
--------------------------------------------------------

--------------------------------------------------------
-- IntelliJ Idea
hs.hotkey.bind({"ctrl", "shift"}, "I", function()
  local launch = hs.application.launchOrFocusByBundleID("com.jetbrains.intellij")
  if not launch then
    hs.alert.show("Vroom cannot launch IntelliJ IDEA :(")
  end
end)
--------------------------------------------------------

--------------------------------------------------------
-- Airmail
hs.hotkey.bind({"ctrl", "shift"}, "M", function()
  local launch = hs.application.launchOrFocus("Airmail 3")
  if not launch then
    hs.alert.show("Vroom cannot launch Airmail 3 :(")
  end
end)
--------------------------------------------------------

--------------------------------------------------------
-- Firefox
hs.hotkey.bind({"ctrl", "shift"}, "F", function()
  local launch = hs.application.launchOrFocusByBundleID("org.mozilla.firefox")
  if not launch then
    hs.alert.show("Vroom cannot launch Firefox :(")
  end
end)
--------------------------------------------------------

--------------------------------------------------------
-- Spotify
hs.hotkey.bind({"ctrl", "shift"}, "S", function()
  local launch = hs.application.launchOrFocusByBundleID("com.spotify.client")
  if not launch then
    hs.alert.show("Vroom cannot launch Spotify :(")
  end
end)
--------------------------------------------------------

--------------------------------------------------------
-- Wechat
hs.hotkey.bind({"ctrl", "shift"}, "W", function()
  local launch = hs.application.launchOrFocusByBundleID("com.tencent.xinWechat")
  if not launch then
    hs.alert.show("Vroom cannot launch Wechat :(")
  end
end)
--------------------------------------------------------

--------------------------------------------------------
-- Atom
hs.hotkey.bind({"ctrl", "shift"}, "E", function()
  local launch = hs.application.launchOrFocusByBundleID("com.github.atom")
  if not launch then
    hs.alert.show("Vroom cannot launch Atom :(")
  end
end)
--------------------------------------------------------

--------------------------------------------------------
-- 2Do
hs.hotkey.bind({"ctrl", "shift"}, "D", function()
  local launch = hs.application.launchOrFocus("2Do")
  if not launch then
    hs.alert.show("Vroom cannot launch 2Do :(")
  end
end)
--------------------------------------------------------

function findApplicationBundleID(name)
  local apps = hs.application.runningApplications()
  for k,v in pairs(apps) do
    if string.find(v:name(), name) ~= nil then
      hs.alert(v:bundleID(), 10)
    end
  end
end

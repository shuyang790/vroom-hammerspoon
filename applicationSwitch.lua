-- Application Swith


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
hs.hotkey.bind({"ctrl", "shift"}, "A", function()
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

function findApplicationBundleID()
  local apps = hs.application.runningApplications()
  for k,v in pairs(apps) do
    if string.find(v:name(), "PATTERN") ~= nil then
      hs.alert(v:bundleID(), 10)
    end
  end
end


require "windowManagement"
require "applicationSwitch"

--------------------------------------------------------
hs.hotkey.bind({"cmd", "ctrl"}, "A", function()
  hs.alert.show("Hello! My name is Vroom :)")
  hs.notify.new({title="Vroom", informativeText="Hello, my friend! :)"})
    :send()
end)

--------------------------------------------------------
-- Reload Config
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
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
-- Paste Password In
hs.hotkey.bind({"cmd", "alt"}, "V", function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
--------------------------------------------------------

--------------------------------------------------------
-- Spotify
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "S", function()
  if hs.spotify.isRunning() then
    hs.alert.show("Track: " .. hs.spotify.getCurrentTrack())
    hs.alert.show("Artist: " .. hs.spotify.getCurrentArtist())
    hs.alert.show("Album: " .. hs.spotify.getCurrentAlbum())
  end
end)
--------------------------------------------------------

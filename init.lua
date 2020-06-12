
require "hs.application"
require "windowManagement"
require "applicationSwitch"
require "layoutManagement"

--------------------------------------------------------
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "A", function()
  hs.alert.show("Hello! My name is Vroom :)")
  hs.notify.new({title="Vroom", informativeText="Hello, my friend! :)"})
    :send()
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
-- Paste Password In
hs.hotkey.bind({"cmd", "alt"}, "V", function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
--------------------------------------------------------

--------------------------------------------------------
-- Spotify
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "S", function()
  if hs.spotify.isRunning() then
    hs.alert.show(
      "Track: " .. hs.spotify.getCurrentTrack() .. "\n"
      .. "Artist: " .. hs.spotify.getCurrentArtist() .. "\n"
      .. "Album: " .. hs.spotify.getCurrentAlbum()
    )
  end
end)
--------------------------------------------------------

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "Q", function()
  hs.caffeinate.lockScreen()
end)

--------------------------------------------------------
hs.timer.doEvery(60 * 60 * 24, function()
  hs.osascript.applescript(
    'tell application "Evernote"' .. "\n"
    .. '  set matches to find notes "notebook:fb-Local"' .. "\n"
    .. '  set htmlPath to "/Volumes/GoogleDrive/My Drive/backup/fb-local-html-" & (current date)' .. "\n"
    .. '  set enexPath to "/Volumes/GoogleDrive/My Drive/backup/fb-local-enex-" & (current date)' .. "\n"
    .. '  export matches to htmlPath format HTML' .. "\n"
    .. '  export matches to enexPath format ENEX' .. "\n"
    .. 'end tell' .. "\n"
  )
  hs.alert.show("Evernote Local Notebook Backed up")
end)

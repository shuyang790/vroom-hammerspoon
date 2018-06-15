-- Application Switch


--------------------------------------------------------
-- Window Hints
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "E", function()
  hs.hints.hintChars = {
    "E", "D", "C",
    "R", "F", "V",
    "Y", "H", "N",
    "U", "J", "M",
    "A", "S",
    "K", "L"
  }
  hs.hints.windowHints(
    hs.window.filter.new()
      :getWindows()
  )
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

-- iTerm
hs.hotkey.bind({"ctrl", "shift"}, "T",
  switchToAppByBundleID("com.googlecode.iterm2")
)

-- IntelliJ Idea
hs.hotkey.bind({"ctrl", "shift"}, "I",
  switchToAppByName("IntelliJ IDEA")
)

-- Email
hs.hotkey.bind({"ctrl", "shift"}, "M",
  -- switchToAppByName("Thunderbird")
  switchToAppByName("Airmail 3")
)

-- Firefox
hs.hotkey.bind({"ctrl", "shift"}, "F",
  switchToAppByBundleID("org.mozilla.firefox")
)

-- Spotify
hs.hotkey.bind({"ctrl", "shift"}, "S",
  switchToAppByBundleID("com.spotify.client")
)

-- Todoist 
-- hs.hotkey.bind({"ctrl", "shift"}, "Y",
--   switchToAppByName("todoist")
-- )

-- Wechat
hs.hotkey.bind({"ctrl", "shift"}, "W",
  switchToAppByBundleID("com.tencent.xinWechat")
)

-- Atom
hs.hotkey.bind({"ctrl", "shift"}, "A",
  switchToAppByName("Atom")
)

-- Evernote
hs.hotkey.bind({"ctrl", "shift"}, "E",
  switchToAppByBundleID("com.evernote.Evernote")
)

-- 2Do / Microsoft To-Do
hs.hotkey.bind({"ctrl", "shift"}, "D",
  -- switchToAppByName("To-Do")
  switchToAppByName("2Do")
)

-- Fantastical 2 / Calendar
hs.hotkey.bind({"ctrl", "shift"}, "C",
  -- switchToAppByName("Calendar")
  switchToAppByName("Fantastical 2")
)

hs.hotkey.bind({"ctrl", "shift"}, "G",
  switchToAppByBundleID("com.fluidapp.FluidApp.Google Calendar")
)

-- Outlook
hs.hotkey.bind({"ctrl", "shift"}, "O",
  switchToAppByBundleID("com.microsoft.Outlook")
)

-- Quip
hs.hotkey.bind({"ctrl", "shift"}, "Q",
  switchToAppByBundleID("com.quip.Desktop")
)

-- Browser
hs.hotkey.bind({"ctrl", "shift"}, "B",
  switchToAppByBundleID("com.google.chrome")
  -- switchToAppByBundleID("com.operasoftware.Opera")
)

-- Vivaldi Browser
hs.hotkey.bind({"ctrl", "shift"}, "V",
  switchToAppByBundleID("com.vivaldi.Vivaldi")
)

-- uTorrent
hs.hotkey.bind({"ctrl", "shift"}, "U",
  switchToAppByBundleID("com.bittorrent.uTorrent")
)

-- Google Play Music Desktop Player
hs.hotkey.bind({"ctrl", "shift"}, "p",
  switchToAppByBundleID("google-play-music-desktop-player")
)

--------------------------------------------------------
-- Helper
function findApplicationBundleID(name)
  local apps = hs.application.runningApplications()
  for k,v in pairs(apps) do
    if string.find(v:name(), name) ~= nil then
      hs.alert(v:bundleID(), 10)
    end
  end
end


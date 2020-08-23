-- Application Switch


--------------------------------------------------------
-- Window Hints
hs.hotkey.bind({"ctrl", "alt"}, "E", function()
  hs.hints.hintChars = {
    "E", "D", "C",
    "R", "F", "V",
    "Y", "H", "N",
    "U", "J", "M",
    "A", "S",
    "K", "L"
  }
  hs.hints.showTitleThresh = 10
  hs.hints.style = "vimperator"
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

-- Atom / VS Code
hs.hotkey.bind({"ctrl", "shift"}, "A",
  switchToAppByName("VS Code @ FB")
)

-- Browser
hs.hotkey.bind({"ctrl", "shift"}, "B",
  switchToAppByName("Safari")
  -- switchToAppByBundleID("com.operasoftware.Opera")
)

-- Fantastical / Calendar
hs.hotkey.bind({"ctrl", "shift"}, "C",
  -- switchToAppByName("Calendar")
  switchToAppByName("Fantastical")
)

-- 2Do
hs.hotkey.bind({"ctrl", "shift"}, "D",
  switchToAppByName("2Do")
)

-- Evernote
hs.hotkey.bind({"ctrl", "shift"}, "E",
  switchToAppByBundleID("com.evernote.Evernote")
)

-- Firefox
hs.hotkey.bind({"ctrl", "shift"}, "F",
  -- switchToAppByName("Firefox Developer Edition")
  switchToAppByBundleID("org.mozilla.firefox")
)

-- Chrome
hs.hotkey.bind({"ctrl", "shift"}, "G",
  switchToAppByBundleID("com.google.chrome")
)

-- IntelliJ Idea
hs.hotkey.bind({"ctrl", "shift"}, "I",
  switchToAppByName("IntelliJ IDEA CE")
)

-- Email
hs.hotkey.bind({"ctrl", "shift"}, "M",
  switchToAppByName("Spark")
  -- switchToAppByName("Thunderbird")
)

-- OmniFocus
hs.hotkey.bind({"ctrl", "shift"}, "N",
  switchToAppByName("OmniFocus")
)

-- Outlook
hs.hotkey.bind({"ctrl", "shift"}, "O",
  switchToAppByBundleID("com.microsoft.Outlook")
)

hs.hotkey.bind({"ctrl", "shift"}, "P",
  switchToAppByName("Music.app")
  -- switchToAppByName("YTM.app")
  -- switchToAppByName("Youtube Music.app")
)

-- Reminders
hs.hotkey.bind({"ctrl", "shift"}, "R",
  switchToAppByName("Reminders")
)

-- Spotify
hs.hotkey.bind({"ctrl", "shift"}, "S",
  switchToAppByBundleID("com.spotify.client")
)

-- iTerm
hs.hotkey.bind({"ctrl", "shift"}, "T",
  switchToAppByBundleID("com.googlecode.iterm2")
)

-- Alternote 
hs.hotkey.bind({"ctrl", "shift"}, "U",
  switchToAppByName("Alternote")
)

-- Vivaldi Browser / VS Code
hs.hotkey.bind({"ctrl", "shift"}, "V",
  switchToAppByBundleID("com.vivaldi.Vivaldi")
  -- switchToAppByName("Visual Studio Code")
)

-- Wechat
hs.hotkey.bind({"ctrl", "shift"}, "W",
  switchToAppByBundleID("com.tencent.xinWechat")
)

-- Microsoft To Do / Todoist 
hs.hotkey.bind({"ctrl", "shift"}, "Y",
  switchToAppByName("Microsoft To Do")
  -- switchToAppByName("todoist")
)

-- Zoom
hs.hotkey.bind({"ctrl", "shift"}, "Z",
  switchToAppByName("zoom.us")
  -- switchToAppByName("todoist")
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


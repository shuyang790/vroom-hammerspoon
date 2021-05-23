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

-- Evernote / Bear
hs.hotkey.bind({"ctrl", "shift"}, "E",
  switchToAppByName("Bear")
  -- switchToAppByName("Evernote")
)


function chrome_switch_to(ppl)
    return function()
        hs.application.launchOrFocus("Google Chrome")
        local chrome = hs.appfinder.appFromName("Google Chrome")
        local str_menu_item
        if ppl == "Incognito" then
            str_menu_item = {"File", "New Incognito Window"}
        else
            str_menu_item = {"People", ppl}
        end
        local menu_item = chrome:findMenuItem(str_menu_item)
        if (menu_item) then
            chrome:selectMenuItem(str_menu_item)
        end
    end
end

-- Chrome
hs.hotkey.bind({"ctrl", "shift"}, "G",
  chrome_switch_to("Shuyang (Personal)")
  -- switchToAppByBundleID("com.google.chrome")
)

-- Firefox / Chrome
hs.hotkey.bind({"ctrl", "shift"}, "F",
  -- switchToAppByName("Firefox Developer Edition")
  switchToAppByBundleID("org.mozilla.firefox")
)

-- IntelliJ Idea
hs.hotkey.bind({"ctrl", "shift"}, "I",
  switchToAppByName("IntelliJ IDEA CE")
)

-- Email
hs.hotkey.bind({"ctrl", "shift"}, "M",
  switchToAppByName("Mail")
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
  switchToAppByName("Microsoft To Do")
  -- switchToAppByName("Music.app")
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

-- Vivaldi / Chrome FB 
hs.hotkey.bind({"ctrl", "shift"}, "V",
  -- chrome_switch_to("Shuyang (Facebook)")
  switchToAppByName("Firefox Developer Edition")
  -- switchToAppByBundleID("com.vivaldi.Vivaldi")
)

-- Wechat
hs.hotkey.bind({"ctrl", "shift"}, "W",
  switchToAppByBundleID("com.tencent.xinWechat")
)

hs.hotkey.bind({"ctrl", "shift"}, "Y",
  switchToAppByName("Typora")
  -- switchToAppByName("Mark Text")
)

-- Zoom
hs.hotkey.bind({"ctrl", "shift"}, "Z",
  switchToAppByName("zoom.us")
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


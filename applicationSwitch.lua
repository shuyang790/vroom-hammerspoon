-- Application Switch

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
  switchToAppByName("iTerm")
)

-- IntelliJ Idea
hs.hotkey.bind({"ctrl", "shift"}, "I",
  switchToAppByName("IntelliJ IDEA")
)

-- Email
hs.hotkey.bind({"ctrl", "shift"}, "M",
  switchToAppByName("Thunderbird")
)

-- Firefox
hs.hotkey.bind({"ctrl", "shift"}, "F",
  switchToAppByBundleID("org.mozilla.firefox")
)

-- Spotify
hs.hotkey.bind({"ctrl", "shift"}, "S",
  switchToAppByBundleID("com.spotify.client")
)

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

-- 2Do
hs.hotkey.bind({"ctrl", "shift"}, "D",
  switchToAppByName("2Do")
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

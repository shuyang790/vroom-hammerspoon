
--------------------------------------------------------
-- VPN status
vpn_menubar = hs.menubar.new()
vpn_menubar:setIcon(hs.image.imageFromPath("./resources/lock.png"):setSize({w=16, h=16}))
vpn_state = true

local function setVPNState(state)
  if not state == vpn_state then 
    vpn_state = state 
    if state then 
      vpn_menubar:setIcon(hs.image.imageFromPath("./resources/lock.png"):setSize({w=16, h=16}))
    else 
      vpn_menubar:setIcon(hs.image.imageFromPath("./resources/unlock.png"):setSize({w=16, h=16}))
    end
  end
end

local function genVPNStatusMessage(state)
  if state then 
    return "VPN connected"
  else 
    return "VPN Not connected"
  end
end

local function checkVPNAndUpdateState()
  local isSuccess, out = hs.osascript.applescript("do shell script \"/opt/cisco/anyconnect/bin/vpn state | sed '/^$/d' | head -3 | tail -1\"")
    if isSuccess then 
      if string.find(out, "Disconnected") then 
        setVPNState(false)
      elseif string.find(out, "Connected") then 
        setVPNState(true)
      end
    end
  vpn_menubar:setMenu({
    {title = "FB VPN", disabled = true },
    -- {title = genVPNStatusMessage(vpn_state), disabled = true },
    {title = "Connect", disabled = vpn_state, fn = function()
      local button, key = hs.dialog.textPrompt("Yubikey", "Please enter passcode from Yubikey", "", "OK", "Cancel")
      hs.alert.show(key)
      if button == "OK" then
        local success, out = hs.osascript.applescript("do shell script \"printf " .. key .." | /opt/cisco/anyconnect/bin/vpn -s connect 'Americas East'\"")
        checkVPNAndUpdateState()
      end
    end},
    {title = "Disconnect", disabled = not vpn_state, fn = function ()
      hs.osascript.applescript("do shell script\"/opt/cisco/anyconnect/bin/vpn disconnect\"")
      checkVPNAndUpdateState()
    end},
    {title = "Refresh", fn = checkVPNAndUpdateState},
  })
end

checkVPNAndUpdateState()
vpn_icon_updater = hs.timer.new(60, checkVPNAndUpdateState)

hs.hotkey.bind({"ctrl", "alt"}, "V", checkVPNAndUpdateState)

vpn_icon_updater:start()

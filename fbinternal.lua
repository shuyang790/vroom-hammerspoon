
--------------------------------------------------------
-- Evernote notebook backup
-- notebook_name = "fb-Local"
-- fb_note_exe, fb_note_cnt = hs.osascript.applescript(
--   'tell application "Evernote"' .. "\n"
--   .. '  set matches to find notes "notebook:' .. notebook_name .. '"' .. "\n"
--   .. '  count matches' .. "\n"
--   .. 'end tell' .. "\n"
-- )
-- if fb_note_exe and fb_note_cnt > 0 then 
--   hs.alert.show("Found " .. fb_note_cnt .. " notes in " .. notebook_name .. " notebook\n Automatic backup on.")
--   evernote_backup_timer = hs.timer.new(60 * 60 * 24, function()
--     hs.osascript.applescript(
--       'tell application "Evernote"' .. "\n"
--       .. '  set matches to find notes "notebook:' .. notebook_name .. '"' .. "\n"
--       .. '  set htmlPath to "/Volumes/GoogleDrive/My Drive/backup/fb-local-html-" & (current date)' .. "\n"
--       .. '  set enexPath to "/Volumes/GoogleDrive/My Drive/backup/fb-local-enex-" & (current date)' .. "\n"
--       .. '  export matches to htmlPath format HTML' .. "\n"
--       .. '  export matches to enexPath format ENEX' .. "\n"
--       .. 'end tell' .. "\n"
--     )
--     hs.alert.show("Evernote Local Notebook Backed up")
--   end)
--   evernote_backup_timer:start()
-- end


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

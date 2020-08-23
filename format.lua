local function replaceWithFormattedHeading()
    local app = hs.application.frontmostApplication()
    if app:name() == "Evernote" then
        hs.eventtap.keyStroke({"cmd"}, "C")
        styledText = hs.pasteboard.readStyledText()
        stringText = styledText:getString()
        presets = {
            {size=30, prefix="# "},
            {size=23, prefix="## "},
            {size=20, prefix="### "},
            {size=17, prefix="#### "}
        }
        fontName = "Helvetica Neue Bold"
        -- hs.alert.show(hs.styledtext.validFont(fontName))
        for i, pair in ipairs(presets) do
            if stringText:sub(1, #pair.prefix) == pair.prefix then
                -- hs.alert.show("prefix " .. pair.prefix .. " " .. pair.size) 
                newText = string.sub(stringText, #pair.prefix + 1, -1)
                formatted = styledText:setString(newText)
                formatted = formatted:setStyle({
                    font={name=fontName, size=pair.size}
                })

                hs.pasteboard.writeObjects(formatted)
                hs.eventtap.keyStroke({"cmd"}, "V")

                return
            end
        end
    end
end

local function findInArray(arr, item)
    for idx, val in ipairs(arr) do 
        if val == item then 
            return true
        end 
    end
    return false
end

-- hs.hotkey.bind({"alt", "shift"}, "H", replaceWithFormattedHeading)
hs.hotkey.bind({"alt", "ctrl"}, "H", function()
    local whitelist = {"Evernote", "TextEdit", "Firefox", "Microsoft OneNote"}
    local app = hs.application.frontmostApplication()
    if findInArray(whitelist, app:name()) then
        hs.eventtap.keyStroke({"cmd"}, "C")
        script = 'do shell script "bash ~/.hammerspoon/md2rtf.sh"'
        hs.osascript.applescript(script)
        hs.eventtap.keyStroke({"cmd"}, "V")
    else
        hs.alert.show("Need to add app " .. app:name() .. ' to the whitelist!')
    end
end)

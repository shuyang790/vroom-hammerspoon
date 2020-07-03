local obj={}
obj.__index = obj

obj.name = "EvernoteSearch"
obj.version = "0.1"
obj.author = "shuyang790 <shuyang790@gmail.com>"

-- Internal function used to find our location, so we know where to load files from
local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

obj.spoonPath = script_path()

-- Define the source's overview. A unique `keyword` key should exist, so this source can be found.
obj.overview = {text="Type r ⇥ to search Evernote notes (updated with 30 days).", keyword="r"}
-- Define the notice when a long-time request is being executed. It could be `nil`.
obj.notice = {text="Requesting data, please wait a while …"}


local function searchOptions()
    local chooser_data = {}
    local flag, output = hs.osascript.applescript('tell application "Evernote"\nset matches to find notes "updated:day-30"\nset notelist to {}\nrepeat with n in matches\nset noteinfo to {title of n, modification date of n as string, note link of n}\ncopy noteinfo to the end of notelist\nend repeat\nreturn notelist\nend tell')
    if flag then 
        chooser_data = hs.fnutils.imap(output, function(item)
            return {text=item[1], subText=item[2], output="open", arg=item[3]}
        end)
    else
        table.insert(chooser_data, {text="Search Evernote", subText=browser, output=nil})
    end
    return chooser_data
end

-- Define the function which will be called when the `keyword` triggers a new source. The returned value is a table. Read more: http://www.hammerspoon.org/docs/hs.chooser.html#choices
obj.init_func = searchOptions
-- Insert a friendly tip at the head so users know what to do next.
obj.description = nil

-- As the user is typing, the callback function will be called for every keypress. The returned value is a table.
obj.callback = nil

return obj

local obj={}
obj.__index = obj

obj.name = "BunnySearch"
obj.version = "0.1"
obj.author = "shuyang790 <shuyang790@gmail.com>"

-- Internal function used to find our location, so we know where to load files from
local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

obj.spoonPath = script_path()

-- Define the source's overview. A unique `keyword` key should exist, so this source can be found.
obj.overview = {text="Type b ⇥ to search via Bunny.", keyword="b"}
-- Define the notice when a long-time request is being executed. It could be `nil`.
obj.notice = {text="Requesting data, please wait a while …"}

local function searchOptions()
    local chooser_data = {}
    table.insert(chooser_data, {text="Search via bunny", subText=browser, output=nil})
    return chooser_data
end

local function updateOptions(queryStr)
    local chooser_data = {}
    local browsers = {"firefox", "chrome", "safari"}
    for idx,browser in ipairs(browsers) do 
        table.insert(chooser_data, {text="(" .. browser .. ") Bunny: " .. queryStr, subText=browser, output=browser, arg="https://bunnylol.facebook.net/?" .. queryStr})
    end
    if spoon.HSearch then 
        spoon.HSearch.chooser:choices(chooser_data)
        spoon.HSearch.chooser:refreshChoicesCallback()
    end
end

-- Define the function which will be called when the `keyword` triggers a new source. The returned value is a table. Read more: http://www.hammerspoon.org/docs/hs.chooser.html#choices
obj.init_func = searchOptions
-- Insert a friendly tip at the head so users know what to do next.
obj.description = nil

-- As the user is typing, the callback function will be called for every keypress. The returned value is a table.
obj.callback = updateOptions

return obj

local json = require("dkjson")
local data = love.filesystem.read("game_data.json")
local info, _, _ = json.decode(data) -- change to something you won't use in your game
local color = {info.rgb.r, info.rgb.g, info.rgb.b}
local name = info.title

local settings = {
    window = {
        title = name,
        borderless = true, 
        fullscreen = false,
    }, 
    color = {
        deep_green = {18, 53, 36}, -- phthalo green
        transparent = color
    }
}

function getScreenDimensions()
    -- only works for Windows
    local handle = io.popen("wmic path Win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution")
    local result = handle:read("*a")
    handle:close()

    local width, height = result:match("(%d+)%s+(%d+)")
    return tonumber(width), tonumber(height)
end

function love.conf(t)
    local win_width, win_height
    if settings.window.fullscreen then
        win_width, win_height = getScreenDimensions()
    else 
        win_width, win_height = 500, 500
    end
    settings.window.width, settings.window.height = win_width, win_height
    t.window.width = settings.window.width
    t.window.height = settings.window.height
    t.window.title = settings.window.title
    t.window.borderless = settings.window.borderless
    t.console = true
end 

return settings 
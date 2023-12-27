local json = require("dkjson")
local data = love.filesystem.read("game_data.json")
local info, _, _ = json.decode(data) -- change to something you won't use in your game
local color = {info.rgb.r, info.rgb.g, info.rgb.b}
local name = info.title

local settings = {
    window = {
        title = name,
        width = 500,
        height = 500,
        borderless = false, 
        fullscreen = false,
    }, 
    color = {
        deep_green = {18, 53, 36}, -- phthalo green
        transparent = color
    }
}

function love.conf(t)
    if settings.window.fullscreen then
        t.window.fullscreen = true
    else 
        t.window.width = settings.window.width
        t.window.height = settings.window.height
    end
    t.window.title = settings.window.title
    t.window.borderless = settings.window.borderless
    t.console = true
end 

return settings 
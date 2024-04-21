local helper = require "love2d-helper/helper"
local settings = require "conf"

function love.load()
    colors = helper:colors()
    love.graphics.setBackgroundColor(colors.phthalo_green)
    range_x = {settings.win_w / 2 - settings.box_size, settings.win_w / 2 + settings.box_size}
    path = trace_path(20)
end

function trace_path(count)
    local path = {}
    for i = 1, count do 
        x = math.random(range_x[1], range_x[2])
        y = settings.win_h - settings.box_size * i
        table.insert(path, {x, y})
    end
    return path 
end

function love.draw()
    for k, v in pairs(path) do
        love.graphics.rectangle("fill", v[1], v[2], settings.box_size  * 2, settings.box_size)
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "space" then
        path = trace_path(20)
    end
end
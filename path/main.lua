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
        table.insert(path, {x=x, y=y})
        range_x[1] = x - settings.box_size 
        if range_x[1] < 0 then 
            range_x[1] = 0
        end
        range_x[2] = x + settings.box_size 
        if range_x[2] > settings.win_w - settings.box_size then
            range_x[2] = settings.win_w - settings.box_size
        end
    end
    return path 
end

function love.draw()
    for k, v in pairs(path) do
        --love.graphics.rectangle("fill", v[1], v[2], settings.box_size  * 2, settings.box_size)
        love.graphics.circle('fill', v.x, v.y, settings.box_size)
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

function love.update(dt)
    for k, v in pairs(path) do
        v.y = v.y + settings.box_size * dt 
        if v.y > settings.win_h then
            table.remove(path, k)
        end
    end
end
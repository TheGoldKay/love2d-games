local helper = require "love2d-helper/helper"
local settings = require "conf"
local Player = require "player"

function love.load()
    colors = helper:colors()
    love.graphics.setBackgroundColor(colors.phthalo_green)
    range_x = {settings.win_w / 2 - settings.box_size, settings.win_w / 2 + settings.box_size}
    path = trace_path(20)
    player = Player("hello", 0)
    print(player.a)
end

function lay_path(i, yn)
    local i = i or 1
    x = math.random(range_x[1], range_x[2])
    if yn then
        y = yn
    else
        y = settings.win_h - settings.box_size * i
    end
    range_x[1] = x - settings.box_size 
    if range_x[1] < 0 then 
        range_x[1] = 0
    end
    range_x[2] = x + settings.box_size 
    if range_x[2] > settings.win_w - settings.box_size then
        range_x[2] = settings.win_w - settings.box_size
    end
    return {x = x, y = y}
end

function trace_path(count)
    local path = {}
    for i = 1, count do 
        table.insert(path, lay_path(i))
    end
    return path 
end

function add_path()
    local last = path[#path]
    local y = last.y - settings.box_size 
    if y < 0 then
        local box = lay_path(nil, y)
        table.insert(path, box)
    end
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
        v.y = v.y + settings.box_speed * dt  * 10
        if v.y > settings.win_h then
            table.remove(path, k)
        end
    end
    add_path()
end
local settings = require 'conf'
local helper = require 'love2d-helper/helper'


function love.load()
    bg_color = helper:hex(settings.bg_color)
    lines = makeLines()
end

function makeLines(count)
    local count = count or settings.num_lines
    local line_w = settings.width / count
    local win_h = settings.height
    local lines = {}
    for i = 1, count - 1 do 
        local x1 = i * line_w
        local y1 = 0 
        local x2 = x1 
        local y2 = win_h
        local line = {x1, y1, x2, y2}
        table.insert(lines, line)
    end 
    return lines 
end 

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end 
end

function drawLines()
    for i, line in ipairs(lines) do
        love.graphics.line(unpack(line))
    end
end

function love.draw()
    love.graphics.setBackgroundColor(bg_color)
    drawLines()
end

function love.update(dt)
end
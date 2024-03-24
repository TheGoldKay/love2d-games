local settings = require 'conf'
local helper = require 'love2d-helper/helper'
local lines = require 'lines'
local keys = require 'keys'

function love.load()
    bg_color = helper:hex(settings.bg_color)
    bg_color = {bg_color[1], bg_color[2], bg_color[3]}
    love.graphics.setBackgroundColor(bg_color)
    lines:makeLines()
    keys:makeKeys()
end

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end 
    if key == 'space' then
        -- save changes and restart without closing and runnnig the game again
        love.event.quit('restart') 
    end
    keys:keyPressed(key)
end

function love.draw()
    keys:drawKeys()
    lines:drawLines()
end

function love.update(dt)
    keys:update(dt)
end
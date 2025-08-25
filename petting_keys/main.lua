package.path = string.format("%s;/home/%s/love2d-helper/?.lua", package.path, os.getenv("USER"))

local settings = require 'conf'
local color = require 'color'
local lines = require 'lines'
local keys = require 'keys'

function love.load()
    bg_color = color:hex(settings.bg_color)
    bg_color = {bg_color[1], bg_color[2], bg_color[3]}
    love.graphics.setBackgroundColor(bg_color)
    lines:makeLines()
    keys:makeKeys()
    local font = love.graphics.newFont(20)
    love.graphics.setFont(font)
    score = 0
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
    love.graphics.setColor({1,0.5,0})
    love.graphics.print("Score: " .. score, 10, 10)
end

function love.update(dt)
    keys:update(dt)
    score = keys:getScore()
end
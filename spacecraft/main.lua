local settings = require("conf")
local love = require("love")
local tp = require("transparent")

function love.load()
    local transparent_color = {0,0,0}--settings.color.deep_green -- change to something you won't use in your game
    love.graphics.setBackgroundColor(rgb(transparent_color)) -- background color equal transparency color mask
    setWindowTransparent(settings.window.title, transparent_color)
    ship = love.graphics.newImage("assets/ship.png")
    ship2 = love.graphics.newImage("assets/ship2.png")
    block = love.graphics.newImage("assets/block.png")
end 

function rgb(r, g, b)
    if type(r) == "table" then
        r, g, b = unpack(r)
    end 
    return {r / 255, g / 255, b / 255} -- love2d colors range 0-1 rather than 0-255
end

function love.draw()
    local winW = love.graphics.getWidth()
    local winH = love.graphics.getHeight()
    love.graphics.setColor(rgb({0,0,0}))
    love.graphics.rectangle("fill", 0, 0, settings.window.width, settings.window.height)
    --love.graphics.setColor(rgb({255,255,255}))
    love.graphics.draw(ship2, winW / 2 - ship2:getWidth() / 2, winH / 2 - ship2:getHeight() / 2)
    
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
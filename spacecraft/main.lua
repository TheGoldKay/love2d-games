local settings = require("conf")
local invisible_window = require("invisible_window")
local player = require("player")
local inspect = require("lib.inspect.inspect")

function love.load()
    love.graphics.setBackgroundColor(rgb(settings.color.transparent)) -- background color equal transparency color mask
    setWindowTransparent(settings.window.title, settings.color.transparent)
    font = love.graphics.newFont(50)
    p = player:new(100, 100, 100, 100)
    p:info()
end 

function showInfo(obj)
    print(inspect(obj))
end

function rgb(r, g, b)
    if type(r) == "table" then
        r, g, b = unpack(r)
    end 
    return {r / 255, g / 255, b / 255} -- love2d colors range 0-1 rather than 0-255
end

function quitText()
    love.graphics.setFont(font)
    love.graphics.setColor({1, 0, 0})
    local text = "Press Esc to quit"
    local x, y = font:getWidth(text), font:getHeight(text)
    love.graphics.print(text, settings.window.width / 2 - x / 2, settings.window.height / 2 - y / 2)
end

function love.draw()
    p:draw(rgb(settings.color.deep_green))
    quitText()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
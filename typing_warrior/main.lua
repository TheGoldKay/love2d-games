local settings = require "conf"

function love.load()
    --love.graphics.setBackgroundColor(rbg(unpack(settings.window.bg_color)))
    bg = {} -- background object
    bg.img = love.graphics.newImage("assets/spacebg.png")
    bg.y = -bg.img:getHeight() + settings.window.height
    bg.vel = 10
end

function rbg(r, g, b)
    return {r / 255, g / 255, b / 255}
end

function love.draw()
    love.graphics.draw(bg.img, 0, bg.y)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.update(dt)
    bg.y = bg.y + bg.vel * dt
    if bg.y > bg.img:getHeight() then
        bg.y = -bg.img:getHeight()
    end
end
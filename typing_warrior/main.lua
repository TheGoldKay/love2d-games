local settings = require "conf"

function love.load()
    --love.graphics.setBackgroundColor(rbg(unpack(settings.window.bg_color)))
    bg = {} -- background object
    bg.img = love.graphics.newImage("assets/spacebg.png")
    bg.y = -bg.img:getHeight() + settings.window.height
    bg.vel = 10
    ship = {} -- ship object
    ship.img = love.graphics.newImage("assets/Emissary.png")
    ship.x = settings.window.width / 2 - ship.img:getWidth() / 2
    ship.y = settings.window.height  - ship.img:getHeight() * 2
    p = {} -- particle object
    p.r = 5 -- the individual particle's radius
    p.adjust = 10
end

function rbg(r, g, b)
    return {r / 255, g / 255, b / 255}
end

function love.draw()
    love.graphics.draw(bg.img, 0, bg.y)
    love.graphics.draw(ship.img, ship.x, ship.y)
    love.graphics.setColor(1, 1, 1)
    --love.graphics.circle("fill", ship.x + ship.img:getWidth() / 2 + p.adjust, ship.y + ship.img:getHeight() - p.adjust, p.r)
    --love.graphics.circle("fill", ship.x + ship.img:getWidth() / 2 - p.adjust, ship.y + ship.img:getHeight() - p.adjust, p.r)
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
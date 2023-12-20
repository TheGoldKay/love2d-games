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
    bullets = {} -- list of bullets (fired)
    bullets.img = love.graphics.newImage("assets/BeholderBullets.png")
    bullets.list = {} -- no bullets fired yet
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
    --love.graphics.setColor(1, 1, 1)
    --love.graphics.circle("fill", ship.x + ship.img:getWidth() / 2 + p.adjust, ship.y + ship.img:getHeight() - p.adjust, p.r)
    --love.graphics.circle("fill", ship.x + ship.img:getWidth() / 2 - p.adjust, ship.y + ship.img:getHeight() - p.adjust, p.r)
    if #bullets.list > 0 then
        for i = 1, #bullets.list do
            love.graphics.draw(bullets.img, bullets.list[i].x, bullets.list[i].y)
        end
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then 
        table.insert(bullets.list, {x = ship.x + ship.img:getWidth() / 4, y = ship.y})
    end
end

function love.update(dt)
    bg.y = bg.y + bg.vel * dt
    if bg.y > bg.img:getHeight() then
        bg.y = -bg.img:getHeight()
    end
    if #bullets.list > 0 then
        for i = 1, #bullets.list do
            bullets.list[i].y = bullets.list[i].y - 10
            if bullets.list[i].y < 0 then
                table.remove(bullets.list, i)
                break
            end
        end
    end
end
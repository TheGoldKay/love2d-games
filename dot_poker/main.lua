require "tesound"

function love.load()
    circle = make_circle()
    explosion = newAnimation(love.graphics.newImage("explosion.png"), 100, 100, 0.3)
    love.graphics.setBackgroundColor(0.15, 0.15, 0.15)
    mousex, mousey = 0, 0
    hit = false 
end

function love.keypressed(key)
    if (key == 'escape') then 
        love.event.quit()
    end
end

function make_circle()
    circle = {}
    circle.x, circle.y = randPoint()
    circle.r = 40 -- radius
    local red, green, blue = love.math.random(), love.math.random(), love.math.random()
    circle.color = {red, green, blue}
    return circle 
end

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end

function love.mousepressed(x, y, button)
    if (button == 1) then 
        if (math.sqrt(math.pow(x - circle.x, 2) + math.pow(y - circle.y, 2)) < circle.r) then 
            TEsound.play("sounds/DeathFlash.flac", "static")
            hit = true
            mousex, mousey = x, y
            make_circle()
        end
    end
end

function randPoint()
    x = love.math.random(WIDTH)
    y = love.math.random(HEIGHT)
    return x, y
end

function love.draw()
    love.graphics.setColor(circle.color)
    love.graphics.circle('fill', circle.x, circle.y, circle.r)
    love.graphics.setColor({1, 1, 1}) -- white
    love.graphics.circle('line', circle.x, circle.y, circle.r+1)
    if (hit) then 
        local spriteNum = math.floor(explosion.currentTime / explosion.duration * #explosion.quads) + 1
        love.graphics.draw(explosion.spriteSheet, explosion.quads[spriteNum], mousex, mousey, 0, 2)
        if(spriteNum == #explosion.quads) then 
            hit = false 
        end 
    end 
end

function love.update(dt)
    TEsound.cleanup()
    explosion.currentTime = explosion.currentTime + dt
    if explosion.currentTime >= explosion.duration then
        explosion.currentTime = explosion.currentTime - explosion.duration
    end
end
require "tesound"

function love.load()
    circle = make_circle()
    love.graphics.setBackgroundColor(.15, .15, .15)
    pop_sound = love.audio.newSource("pop.mp3", "static")
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

function love.mousepressed(x, y, button)
    if (button == 1) then 
        if (math.sqrt(math.pow(x - circle.x, 2) + math.pow(y - circle.y, 2)) < circle.r) then 
            TEsound.play("pop.mp3", "static")
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
end

function love.update()
    TEsound.cleanup()
end
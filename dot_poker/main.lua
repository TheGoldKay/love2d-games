function love.load()
    circle = {}
    circle.x, circle.y = randPoint()
    circle.r = 40 -- radius
    circle.color = {0, .5, .5}
    love.graphics.setBackgroundColor(.15, .15, .15)
end

function love.keypressed(key)
    if(key == 'escape') then 
        love.event.quit()
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
end
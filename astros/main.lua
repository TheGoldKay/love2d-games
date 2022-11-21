Player = require('player')
Enemy = require('enemy')

function love.load()
    player = Player:new()
    astros = Enemy:new()
end 

function love.keypressed(key)
    if (key == 'escape') then 
        love.event.quit()
    elseif (key == 'space') then 
        player:fire()
    end 
end

function love.draw()
    player:draw()
    astros:draw()
end

function love.update(dt)
    player:update(dt)
    astros:make_astro()
    astros:update(dt)
end 
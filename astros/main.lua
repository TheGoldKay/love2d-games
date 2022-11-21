Player = require('player')

function love.load()
    player = Player:new()
end 

function love.keypressed(key)
    if (key == 'escape') then 
        love.event.quit()
    end 
end

function love.draw()
    player:draw()
end

function love.update(dt)
    player:update(dt)
end 
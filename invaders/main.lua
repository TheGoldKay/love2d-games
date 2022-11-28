Ships = require("ships")
Player = require('player')

function love.load()
    ships = Ships:new()
    player = Player:new()
end 

function love.keypressed(key)
    if(key == 'escape') then 
        love.event.quit()
    elseif(key == 'space') then 
        player:fire()
    end
end

function love.draw()
    ships:draw()
    player:draw()
end

function love.update(dt)
    ships:update(dt)
    player:update(dt)
    if(math.random(1, 1000) < 50) then 
        ships:fire()
    end
end
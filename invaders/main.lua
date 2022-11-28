Ships = require("ships")

function love.load()
    ships = Ships:new()
end 

function love.keypressed(key)
    if(key == 'escape') then 
        love.event.quit()
    end 
end

function love.draw()
    ships:draw()
end
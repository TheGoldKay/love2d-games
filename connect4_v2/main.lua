Grid = require('grid')

function love.load()
    grid = Grid:new()
end

function love.keypressed(key)
    if(key == 'escape') then 
        love.event.quit()
    end
end

function love.draw()
    grid:draw()
end
Pieces = require ('pieces')

function love.load()
    pieces = Pieces:new()
end 

function love.keypressed(key)
    if (key == 'escape') then 
        love.event.quit()
    end 
end 

function love.draw()
    pieces:draw()
end
Pieces = require ('pieces')

function love.load()
    pieces = Pieces:new()
end 

function love.keypressed(key)
    if (key == 'escape') then 
        love.event.quit()
    end 
    if (key == 'space' or key == 'w') then 
        pieces:rotate()
    end 
end 

function love.draw()
    pieces:draw()
end
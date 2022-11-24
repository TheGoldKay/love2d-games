Pieces = require ('pieces')
Grid = require ('grid')

function love.load()
    pieces = Pieces:new()
    grid = Grid:new()
end 

function love.keypressed(key)
    if (key == 'escape') then 
        love.event.quit()
    end 
    if (key == 'space' or key == 'w') then 
        pieces:rotate()
    end 
    if (key == 'a' or key == 'left') then 
        if(pieces.col > 0) then 
            pieces.col = pieces.col - 1
        end 
    elseif (key == 'd' or key == 'right') then 
        if(pieces.col < win_w) then 
            pieces.col = pieces.col + 1 
        end 
    end 
end 

function love.draw()
    pieces:draw()
    grid:draw()
end

function love.update(dt)
    pieces:update(dt)
end 
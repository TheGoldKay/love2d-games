Pieces = require ('pieces')
Grid = require ('grid')

function love.load()
    love.graphics.setBackgroundColor(0, 0.3, 0.1)
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
        if(pieces:can_move_x()) then 
            pieces.col = pieces.col - 1
        end 
    elseif (key == 'd' or key == 'right') then 
        if(pieces:can_move_x()) then 
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
    pieces:piece_collision()
end 
Grid = require('grid')

function love.load()
    grid = Grid:new()
end

function love.keypressed(key)
    if(key == 'escape') then 
        love.event.quit()
    elseif(key == 'left' or key == 'a') then 
        if(grid.player.x > 1) then 
            grid.player.x = grid.player.x - 1
        end
    elseif(key == 'right' or key == 'd') then 
        if(grid.player.x < grid.ncol) then 
            grid.player.x = grid.player.x + 1
        end
    elseif(key == 'space') then 
        grid:player_fall()
    end 
end

function love.draw()
    grid:draw()
    grid:check_diags()
end

function love.update(dt)
    --grid:check_diags()
end
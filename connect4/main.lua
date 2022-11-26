Grid = require("grid")

function love.load()
    grid = Grid:new()
end 

function love.keypressed(key)
    if(key == 'escape') then 
        love.event.quit()
    elseif (key == 'left' or key == 'a') then 
        grid.player.x = grid.player.x - grid.size 
    elseif (key == 'right' or key == 'd') then 
        grid.player.x = grid.player.x + grid.size
    end
    if(grid.player.x < grid.gap) then grid.player.x = grid.gap + grid.size / 2 end
    if(grid.player.x > grid.gap + grid.col * grid.size) then grid.player.x = grid.gap + grid.col * grid.size - grid.size / 2 end 
end

function love.draw()
    grid:draw()
end
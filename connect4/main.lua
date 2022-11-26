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
    elseif (key == 'space')  then 
        while (true) do
            grid.player.y = grid.player.y + grid.size
            if(grid.player.y > love.graphics.getHeight()) then 
                grid.player.y = love.graphics.getHeight() - grid.size  / 2
                grid:create_player()
                break
            end
            for i, line in pairs(grid.list) do 
                for j, cell in pairs(line) do 
                    if(grid.player.y == cell.circle.y and grid.player.x == cell.circle.x) then 
                        grid.list[i][j].mode = 'fill'
                        break
                    end 
                end 
            end
        end
    end 
    if(grid.player.x < grid.gap) then grid.player.x = grid.gap + grid.size / 2 end
    if(grid.player.x > grid.gap + grid.col * grid.size) then grid.player.x = grid.gap + grid.col * grid.size - grid.size / 2 end 
end

function love.draw()
    grid:draw()
end
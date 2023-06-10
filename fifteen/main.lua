function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    cell = makeCell()
    grid = makeGrid(4, 4)
end

function love.keypressed(key)
    if(key == "escape") then 
        love.event.quit()
    end
end

function makeCell()
    local cell = {}
    cell.size = 100
    cell.color = {.4, .1, .6}
    return cell 
end 

function makeGrid(row, col)
    local num = 0
    local grid = {}
    for r = 1, row do 
        local line = {}
        for c = 1, col do 
            num = num + 1
            table.insert(line, num)
        end
        table.insert(grid, line)
    end
    return grid 
end

function randColor()
    local r = love.math.random()
    local g = love.math.random()
    local b = love.math.random()
    return {r, g, b}
end

function love.draw()
    for row, line in ipairs(grid) do 
        for col, num in ipairs(line) do 
            local y = (row - 1) * cell.size
            local x = (col - 1) * cell.size
            love.graphics.setColor(cell.color)
            love.graphics.rectangle("fill", x, y, cell.size, cell.size)
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("line", x, y, cell.size, cell.size)
            love.graphics.setColor(1, 1, 1)
            love.graphics.print(num, x + cell.size / 2, y + cell.size / 2)
        end
    end
end

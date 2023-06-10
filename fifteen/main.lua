function love.load()
    cell = makeCell()
    grid = makeGrid(4, 4)
    font = makeFont()
    blank = {4, 4} -- the number 16 (last one is black) (row, col)
    shuffle_clock = 0 
    shuffle_timer = .08
    shuffle_steps = 30
    math.randomseed(os.time())
end

function makeFont()
    local font = {}
    font.size = 24
    font.font = love.graphics.newFont(font.size)
    return font 
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

function allowedMoves()
    local row, col = blank[1], blank[2]
    local moves = {}
    if(row + 1 <= 4) then 
        table.insert(moves, 'w')
    end 
    if(row - 1 >= 1) then 
        table.insert(moves, 's')
    end
    if(col + 1 <= 4) then 
        table.insert(moves, 'a')
    end
    if(col - 1 >= 1) then 
        table.insert(moves, 'd')
    end
    return moves 
end

function shuffleTiles()
    if(shuffle_clock >= shuffle_timer and shuffle_steps > 0) then 
        local moves = allowedMoves()
        local key = moves[math.random(#moves)]
        tileMove(key)
        shuffle_steps = shuffle_steps - 1
        shuffle_clock = 0
    end 
end

function tileMove(key)
    local row, col = blank[1], blank[2]
    if(key == 's') then 
        if(row - 1 >= 1) then 
            local num = grid[row - 1][col]
            grid[row][col] = num 
            grid[row - 1][col] = 16 
            blank = {row - 1, col}
        end
    elseif(key == 'w') then 
        if(row + 1 <= 4) then 
            local num = grid[row + 1][col]
            grid[row][col] = num 
            grid[row + 1][col] = 16
            blank = {row + 1, col}
        end
    elseif(key == 'a') then 
        if(col + 1 <= 4) then 
            local num = grid[row][col + 1]
            grid[row][col] = num 
            grid[row][col + 1] = 16 
            blank = {row, col + 1}
        end
    elseif(key == 'd') then 
        if(col - 1 >= 1) then 
            local num = grid[row][col - 1]
            grid[row][col] = num 
            grid[row][col - 1] = 16 
            blank = {row, col - 1}
        end
    end
end

function love.keypressed(key)
    if(key == "escape") then 
        love.event.quit()
    end
    tileMove(key)
    if(key == 'space') then 
        shuffleTiles(10)
    end
end


function love.draw()
    for row, line in ipairs(grid) do 
        for col, num in ipairs(line) do 
            local y = (row - 1) * cell.size
            local x = (col - 1) * cell.size
            if(num ~= 16) then 
                love.graphics.setColor(cell.color)
                love.graphics.rectangle("fill", x, y, cell.size, cell.size)
                love.graphics.setColor(1, 1, 1)
                love.graphics.print(num, font.font, x + cell.size / 2 - font.size / 2, y + cell.size / 2 - font.size / 2)
            end
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("line", x, y, cell.size, cell.size)
        end
    end
end

function love.update(dt)
    if(shuffle_steps > 0) then 
        shuffleTiles()
        shuffle_clock = shuffle_clock + dt 
    end 
end
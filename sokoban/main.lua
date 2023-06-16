function love.load()
    levels = require "levels"
    player = '@'
    playerOnStorage = '+'
    box = '$'
    boxOnStorage = '*'
    storage = '.'
    wall = '#'
    empty = ' '
    colors = {
        [player] = {.64, .53, 1},
        [playerOnStorage] = {.62, .47, 1},
        [box] = {1, .79, .49},
        [boxOnStorage] = {.59, 1, .5},
        [storage] = {.61, .9, 1},
        [wall] = {1, .58, .82},
        [empty] = {1, 1, .75},
    }
    cell_size = 23
    current_level = 3
    love.graphics.setBackgroundColor(colors[empty])
end

function getPlayerPos()
    for row, line in ipairs(levels[current_level]) do 
        for col, item in ipairs(line) do 
            if(item == player or item == playerOnStorage) then 
                return row, col
            end
        end
    end
end  

function nextLevel()
    current_level = current_level + 1
end 

function love.keypressed(key)
    if(key == "escape") then 
        love.event.quit()
    end
    if(key == "space") then 
        nextLevel()
    end
    if(key == "up" or key == "w" or key == "down" or key == "s" or key == "right" or key == "d" or key == "left" or key == "a") then 
        local level = levels[current_level]
        local row, col = getPlayerPos()
        local dx, dy = 0, 0
        if(key == "up" or key == "w") then 
            dy = -1
        elseif(key == "down" or key == "s") then 
            dy = 1
        elseif(key == "left" or key == "a") then 
            dx = -1
        elseif(key == "right" or key == "d") then 
            dx = 1
        end 
        local nrow, ncol = dy + row, dx + col
        local current = level[row][col]
        local adjacent = level[nrow][ncol]
        local beyond = level[nrow + dy][ncol + dx]
        if(current == player and adjacent == empty) then 
            level[row][col] = empty
            level[nrow][ncol] = player
        elseif(current == player and adjacent == storage) then 
            level[row][col] = empty
            level[nrow][ncol] = playerOnStorage
        elseif(current == playerOnStorage and adjacent == storage) then 
            level[row][col] = storage
            level[nrow][ncol] = playerOnStorage
        elseif(current == playerOnStorage and adjacent == empty) then 
            level[row][col] = storage
            level[nrow][ncol] = player
        elseif(current == player and adjacent == box)
        if(beyond) then 
            if(current == player and adjacent == box and beyond == empty) then 
                level[row][col] = empty
                level[nrow][ncol] = player
                level[nrow + dy][ncol + dx] = box 
            elseif(current == player and adjacent == box and beyond == box) then 
                level[row][col] = empty
                level[nrow][ncol] = player
                level[nrow + dy][ncol + dx] = box 
            end
        end
     end
end

function drawLevel()
    local level = levels[current_level]
    for i, line in ipairs(level) do 
        for j, char in ipairs(line) do
            local x, y = cell_size * j, cell_size * i 
            love.graphics.setColor(colors[char])
            love.graphics.rectangle("fill", x, y, cell_size, cell_size)
            love.graphics.setColor(1, 1, 1)
            love.graphics.print(char, x, y)
        end
    end
end

function love.draw()
    drawLevel()
end
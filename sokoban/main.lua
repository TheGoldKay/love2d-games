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
    current_level = 2
    love.graphics.setBackgroundColor(colors[empty])
end

function getPlayerPos()
    for i, row in ipairs(levels[current_level]) do 
        for j, item in ipairs(row) do 
            if(item == player) then 
                return i, j 
            end
        end
    end
end  

function nextLevel()
    current_level = current_level + 1
end 

function love.keypressed(key)
    local level = levels[current_level]
    local p_row, p_col = getPlayerPos()
    if(key == "escape") then 
        love.event.quit()
    end
    if(key == 'a') then 
        if(level[p_row][p_col] == player) then 
            if(level[p_row][p_col - 1] == empty) then 
                level[p_row][p_col] = empty
                level[p_row][p_col - 1] = player
            elseif(level[p_row][p_col - 1] == box and level[p_row][p_col - 2] == empty) then 
                level[p_row][p_col - 2] = box 
                level[p_row][p_col - 1] = player  
                level[p_row][p_col] = empty
            elseif(level[p_row][p_col - 1] == box and level[p_row][p_col - 2] == storage) then 
                level[p_row][p_col - 2] = boxOnStorage
                level[p_row][p_col - 1] = player
                level[p_row][p_col] = empty
            elseif(level[p_row][p_col - 1] == boxOnStorage and level[p_row][p_col - 2] == storage) then 
                level[p_row][p_col - 1] = playerOnStorage
                level[p_row][p_col - 2] = boxOnStorage
                level[p_row][p_col] = empty
            end
        else 
            if(level[p_row][p_col - 1] == boxOnStorage and level[p_row][p_col - 2] == storage) then 
                level[p_row][p_col - 1] = playerOnStorage
                level[p_row][p_col - 2] = boxOnStorage
                level[p_row][p_col] = storage 
            elseif(level[p_row][p_col - 1] == empty) then 
                level[p_row][p_col - 1] = player
                level[p_row][p_col] = storage
            end
        end
    elseif(key == 'd') then 
        if(level[p_row][p_col + 1] == empty) then 
            level[p_row][p_col] = empty
            level[p_row][p_col + 1] = player
        elseif(level[p_row][p_col + 1] == box and level[p_row][p_col + 2] == empty) then 
            level[p_row][p_col + 2] = box 
            level[p_row][p_col + 1] = player  
            level[p_row][p_col] = empty
        elseif(level[p_row][p_col + 1] == box and level[p_row][p_col + 2] == storage) then 
            level[p_row][p_col + 2] = boxOnStorage
            level[p_row][p_col + 1] = player
            level[p_row][p_col] = empty
        end
    elseif(key == 'w') then 
        if(level[p_row - 1][p_col] == empty) then 
            level[p_row][p_col] = empty
            level[p_row - 1][p_col] = player
        elseif(level[p_row - 1][p_col] == box and level[p_row - 2][p_col] == empty) then 
            level[p_row - 2][p_col] = box 
            level[p_row - 1][p_col] = player  
            level[p_row][p_col] = empty
        elseif(level[p_row - 1][p_col] == box and level[p_row - 2][p_col] == storage) then 
            level[p_row - 2][p_col] = boxOnStorage
            level[p_row - 1][p_col] = player
            level[p_row][p_col] = empty
        end
    elseif(key == 's') then 
        if(level[p_row + 1][p_col] == empty) then 
            level[p_row][p_col] = empty
            level[p_row + 1][p_col] = player
        elseif(level[p_row + 1][p_col] == box and level[p_row + 2][p_col] == empty) then 
            level[p_row + 2][p_col] = box 
            level[p_row + 1][p_col] = player  
            level[p_row][p_col] = empty
        elseif(level[p_row + 1][p_col] == box and level[p_row + 2][p_col] == storage) then 
            level[p_row + 2][p_col] = boxOnStorage
            level[p_row + 1][p_col] = player
            level[p_row][p_col] = empty
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
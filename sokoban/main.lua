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
    current_level = 1
    love.graphics.setBackgroundColor(colors[empty])
end

function love.keypressed(key)
    if(key == "escape") then 
        love.event.quit()
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
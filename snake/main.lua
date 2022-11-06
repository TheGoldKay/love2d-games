Snake = require 'snake'

function  love.load()
    snake = Snake:init()
end 

function love.draw()
    snake:draw()
end

function love.keypressed(key)
    if key == 'w' and snake.dir ~= 'down' then 
        snake.dir = 'up'
    elseif key == 's' and snake.dir ~= 'up' then 
        snake.dir = 'down'
    elseif key == 'a' and snake.dir ~= 'right' then 
        snake.dir = 'left'
    elseif key == 'd' and snake.dir ~= 'left' then 
        snake.dir = 'right'
    elseif key == 'escape' then 
        love.event.quit()
    end
end 

function love.update(dt)
    snake:move(dt)
end
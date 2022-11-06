Snake = require 'snake'

function  love.load()
    snake = Snake:init()
end 

function love.draw()
    snake:draw()
end

function love.keypressed(key)
    if key == 'w' then 
        snake.dir = 'up'
    elseif key == 's' then 
        snake.dir = 'down'
    elseif key == 'a' then 
        snake.dir = 'left'
    elseif key == 'd' then 
        snake.dir = 'right'
    elseif key == 'escape' then 
        love.event.quit()
    end
end 

function love.update(dt)
    snake:move(dt)
end
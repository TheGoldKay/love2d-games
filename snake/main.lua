Snake = require 'snake'

function  love.load()
    snake = Snake:init()
end 

function love.draw()
    snake:draw()
end

function love.keypressed(key)
    if key == 'w'and snake.vertical == false then 
        snake.yvel = -snake.vel
        snake.xvel = 0 
        snake.vertical = true 
        snake.horizontal = false
    elseif key == 's'and snake.vertical == false then 
        snake.yvel = snake.vel 
        snake.xvel = 0
        snake.vertical = true
        snake.horizontal = false 
    elseif key == 'a' and snake.horizontal == false then 
        snake.xvel = -snake.vel
        snake.yvel = 0
        snake.horizontal = true 
        snake.vertical = false 
    elseif key == 'd' and snake.horizontal == false then 
        snake.xvel = snake.vel 
        snake.yvel = 0
        snake.horizontal = true 
        snake.vertical = false
    elseif key == 'escape' then 
        love.event.quit()
    end
end 

function love.update(dt)
    snake:move(dt)
end
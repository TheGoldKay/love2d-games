Snake = require('snake')
Food = require('food')

function  love.load()
    love.graphics.setBackgroundColor(0.3, 0.3, 0.3)
    snake = Snake:init()
    food = Food:init(snake.xmax, snake.ymax, snake.s)
end 

function love.draw()
    snake:draw()
    food:draw()
end

function love.keypressed(key)
    if key == 'w' or key == "up" and snake.dir ~= 'down' then 
        snake.dir = 'up'
    elseif key == 's' or key == "down" and snake.dir ~= 'up' then 
        snake.dir = 'down'
    elseif key == 'a' or key == "left" and snake.dir ~= 'right' then 
        snake.dir = 'left'
    elseif key == 'd' or key == "right" and snake.dir ~= 'left' then 
        snake.dir = 'right'
    elseif key == 'escape' then 
        love.event.quit()
    end
end 

function love.update(dt)
    snake:update(dt)
    snake:move(dt)
    snake:eat(food)
end
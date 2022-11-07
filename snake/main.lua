Snake = require('snake')
Food = require('food')

function  love.load()
    snake = Snake:init()
    food = Food:init(snake.xmax, snake.ymax, snake.s)
end 

function love.draw()
    snake:draw()
    food:draw()
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
    food = snake:eat(food)
end
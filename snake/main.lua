Snake = require 'snake'

function  love.load()
    snake = Snake:init()
end 

function love.draw()
    snake:draw()
end
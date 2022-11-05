Player = require 'player'
Ball = require 'ball'

function love.load()
    love.graphics.setBackgroundColor(0, 0.5, 0.2)
    player = Player:init()
    ball = Ball:init()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end 
end

function love.draw()
    player:draw()
    ball:draw()
end 

function isColliding(p, b, x, y)
    if ((x >= p.x + p.width) or
        (x + b.radius + b.radius/2 <= p.x) or
        (y >= p.y + p.height) or
        (y + b.radius <= p.y)) then
           return false 
    else 
        return true
    end
end

function love.update(dt)
    player:move(dt)
    ball:move(dt)
    x = ball.x - ball.radius/2
    y = ball.y 
    if isColliding(player, ball, x, y) then 
        ball.xvel = -ball.xvel
        print('hit')
    end
end 
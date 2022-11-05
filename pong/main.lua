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

function isColliding(a, b)
    if ((b.x >= a.x + a.width) or
        (b.x + b.radius <= a.x) or
        (b.y >= a.y + a.height) or
        (b.y + b.radius <= a.y)) then
           return false 
    else 
        return true
    end
end

function love.update(dt)
    player:move(dt)
    ball:move(dt)
    if isColliding(player, ball) then 
        ball.xvel = -ball.xvel
        print('hit')
    end
end 
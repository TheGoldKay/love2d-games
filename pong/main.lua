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

function love.update(dt)
    player:move(dt)
    ball:move(dt, player    )
end 
Pallet = require('pallet')

function love.load()
    pallet = Pallet:init()
    ball = {}
    ball.x = love.graphics.getWidth() / 2
    ball.y = love.graphics.getHeight() / 2
    ball.r = 20
end 

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end 
end 

function love.draw()
    pallet:draw()
    love.graphics.circle('line', ball.x, ball.y, ball.r)
end 

function love.update(dt)
    pallet:move(dt)
end 
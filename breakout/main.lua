Pallet = require('pallet')
Ball = require('ball')

function love.load()
    pallet = Pallet:init()
    ball = Ball:init()
end 

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end 
end 

function love.draw()
    pallet:draw()
    ball:draw()
end 

function love.update(dt)
    pallet:move(dt)
    ball:move(dt, pallet)
end 
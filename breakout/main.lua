Pallet = require('pallet')
Ball = require('ball')
Grid = require('grid')

function love.load()
    pallet = Pallet:init()
    ball = Ball:init()
    grid = Grid:init()
end 

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end 
end 

function love.draw()
    pallet:draw()
    ball:draw()
    grid:draw()
end 

-- Assuming a = {x = ..., y = ..., width = ..., height = ...}
-- Assuming b = {x = ..., y = ..., width = ..., height = ...}

function isColliding(a,b)
    if ((b.x >= a.x + a.w) or
        (b.x + b.w <= a.x) or
        (b.y >= a.y + a.h) or
        (b.y + b.h <= a.y)) then
            return false 
        else 
            return true
    end
end
 
function love.update(dt)
    pallet:move(dt)
    ball:move(dt, pallet)
    if isColliding(ball, pallet) then 
        ball.yvel = -ball.yvel
    end 
end 
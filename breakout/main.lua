Pallet = require('pallet')

function love.load()
    pallet = Pallet:init()
end 

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end 
end 

function love.draw()
    pallet:draw()
end 

function love.update(dt)
    pallet:move(dt)
end 
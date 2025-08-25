Pallet = {}
Pallet.__index = Pallet

function Pallet:init()
    self = setmetatable({}, self)
    self.w = 240
    self.h = 20
    self.vel = 500
    self.x = love.graphics.getWidth() / 2 - self.w / 2
    self.y = love.graphics.getHeight() - self.h
    return self 
end 

function Pallet:draw()
    love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end 

function Pallet:move(dt)
    if love.keyboard.isDown('a', 'left') and self.x > 0 then 
        self.x = self.x - self.vel * dt 
    elseif love.keyboard.isDown('d', 'right') and self.x + self.w < love.graphics.getWidth() then 
        self.x = self.x + self.vel * dt 
    end 
end 
return Pallet 
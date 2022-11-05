

Player = {}

Player.__index = Player

function Player:init()
    self = setmetatable({}, self)     
    self.width = 30
    self.height = 150
    self.x = 0
    self.y = love.graphics.getHeight() / 2 - self.height / 2
    self.color = {0, .1, .2}
    self.speed = 500
    return self
end 

function Player:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end 

function Player:move(dt)
    if love.keyboard.isDown('w', 'up') and self.y > 0 then
        self.y = self.y - self.speed * dt 
    elseif love.keyboard.isDown('s', 'down') and self.y + self.height < love.graphics.getHeight() then 
        self.y = self.y + self.speed * dt 
    end 
end 

return Player

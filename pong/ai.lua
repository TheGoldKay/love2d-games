
Ai = {}
Ai.__index = Ai 

function Ai:init()
    self = setmetatable({}, self)
    self.width = 30
    self.height = 150
    self.x = love.graphics.getWidth() - self.width
    self.y = love.graphics.getHeight() / 2 - self.height / 2
    self.color = {0, .1, .2}
    self.speed = 500
    return self
end 

function Ai:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end 

function Ai:move(dt, ball)
    if ball.y < self.y then 
        self.y = self.y - self.speed * dt 
    elseif ball.y > self.y + self.height then 
        self.y = self.y + self.speed * dt 
    end 
end 

return Ai 

Ball = {}

Ball.__index = Ball 

function Ball:init()
    self = setmetatable({}, self)
    self.radius = 20
    self.x = love.graphics.getWidth() / 2 - self.radius / 2
    self.y = love.graphics.getHeight() / 2 - self.radius / 2
    self.color = {1, 1, 1}
    self.speed = 300
    self.xvel = self.speed
    self.yvel = self.speed
    return self 
end 

function Ball:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle('fill', self.x, self.y, self.radius)
end 

function Ball:move(dt, p)
    self.x = self.x + self.xvel * dt 
    self.y = self.y + self.yvel * dt  
    if self.x <= 0 or self.x >= love.graphics.getWidth() then 
        self.xvel = -self.xvel 
    elseif self.y <= 0 or self.y >= love.graphics.getHeight() then 
        self.yvel = -self.yvel 
    end
end  

return Ball 
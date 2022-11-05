
Ball = {}

Ball.__index = Ball 

function Ball:init()
    self = setmetatable({}, self)
    self.radius = 20
    self.x = love.graphics.getWidth() / 2 - self.radius / 2
    self.y = love.graphics.getHeight() / 2 - self.radius / 2
    self.color = {1, 1, 1}
    return self 
end 

function Ball:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle('fill', self.x, self.y, self.radius)
end 


return Ball 
Food = {}
Food.__index = Food 

function Food:init(xmax, ymax, size)
    self = setmetatable({}, self)
    self.xmax = xmax
    self.ymax = ymax
    self.s = size 
    self:new()
    return self 
end 

function Food:new()
    self.x = love.math.random(0, self.xmax)
    self.y = love.math.random(0, self.ymax)
end 

function Food:draw()
    love.graphics.rectangle('fill', self.x * self.s, self.y * self.s, self.s, self.s)
end 

return Food
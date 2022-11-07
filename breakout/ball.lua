Ball = {}
Ball.__index = Ball 

function Ball:init()
    self = setmetatable({}, self)
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.r = 20
    return self
end 

function Ball:draw()
    love.graphics.circle('line', ball.x, ball.y, ball.r)
end 

return Ball 
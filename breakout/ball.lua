Ball = {}
Ball.__index = Ball 

function Ball:init()
    self = setmetatable({}, self)
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.r = 20
    self.vel = 300
    self.xvel = self.vel
    self.yvel = self.vel 
    return self
end 

function Ball:draw()
    love.graphics.circle('line', ball.x, ball.y, ball.r)
end 

function Ball:collide(p) 
    if self.y + self.r > p.y and self.x > p.x and self.x < p.x + p.w then 
        self.yvel = -self.yvel 
    end 
end 

function Ball:move(dt, p)
    self.x = self.x + self.xvel * dt 
    self.y = self.y + self.yvel * dt 
    if self.x <= 0 or self.x + self.r >= love.graphics.getWidth() then 
        self.xvel = -self.xvel 
    elseif self.y <= 0 or self.y + self.r >= love.graphics.getHeight() then 
        self.yvel = -self.yvel 
    end 
    self:collide(p)
end 

return Ball 
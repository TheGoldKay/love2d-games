Player = {}
Player.__index = Player

function Player:new()
    self = setmetatable({}, self)
    self.size = 20
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() - self.size 
    self.speed = 200
    return self 
end

function Player:draw()
    love.graphics.circle('fill', self.x, self.y, self.size)
end

function Player:update(dt)
    if love.keyboard.isDown('d', 'right') then 
        self.x = self.x + self.speed * dt 
    elseif (love.keyboard.isDown('a', 'left')) then
        self.x = self.x - self.speed * dt
    end
end

return Player
Player = {}
Player.__index = Player


function Player:new()
    self = setmetatable({}, self)
    self.x = win_w / 2
    self.y = win_h / 2
    self.r = 40
    self.vel = 10
    self.a = 0
    self.avel = 400
    return self 
end

function Player:draw()
    local a = math.rad(self.a)
    love.graphics.circle('line', self.x, self.y, self.r)
    love.graphics.circle('fill', self.x + math.cos(a) * self.r, self.y + math.sin(a) * self.r, self.r/5)
end

function Player:update(dt)
    if (self.x <= 0) then 
        self.x = win_w
    elseif(self.x >= win_w) then 
        self.x = 0 
    end 
    if (self.y <= 0) then 
        self.y = win_h
    elseif (self.y >= win_h) then 
        self.y = 0
    end 
    if love.keyboard.isDown('w', 'up') then 
        self.x = self.x + math.cos(math.rad(self.a)) * self.r * dt * self.vel
        self.y = self.y + math.sin(math.rad(self.a)) * self.r * dt * self.vel 
    end 
    if love.keyboard.isDown('a', 'left') then 
        self.a = self.a - self.avel * dt 
    elseif love.keyboard.isDown('d', 'right') then 
        self.a = self.a + self.avel * dt 
    end 
    self.a = self.a % 360
end 

return Player 
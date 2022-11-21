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
    self.bvel = 300
    self.bullets = {}
    return self 
end

function Player:draw()
    local a = math.rad(self.a)
    love.graphics.circle('line', self.x, self.y, self.r)
    love.graphics.circle('fill', self.x + math.cos(a) * self.r, self.y + math.sin(a) * self.r, self.r/5)
    for _, b in pairs(self.bullets) do 
        love.graphics.circle('line', b.x, b.y, b.r)
    end 
end

function Player:fire()
    local a = math.rad(self.a)
    local x, y = self.x + math.cos(a) * self.r, self.y + math.sin(a) * self.r
    local bullet = {}
    bullet.a = a 
    bullet.x = x 
    bullet.y = y 
    bullet.r = self.r/5
    table.insert(self.bullets, bullet)
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
    for i, b in pairs(self.bullets) do 
        b.x = b.x + math.cos(b.a) * dt * self.bvel 
        if(b.x <= 0 or b.x >= win_w) then 
            self.bullets[i] = nil 
        end 
        b.y = b.y + math.sin(b.a) * dt * self.bvel 
        if(b.y <= 0 or b.y >= win_h) then 
            self.bullets[i] = nil 
        end 
    end 
end 

return Player 
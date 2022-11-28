Player = {}
Player.__index = Player

function Player:new()
    self = setmetatable({}, self)
    self.size = 20
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() - self.size 
    self.speed = 200
    self.mode = 'line'
    self.bullets = {}
    return self 
end

function Player:draw()
    love.graphics.circle(self.mode, self.x, self.y, self.size)
    for i, bullet in pairs(self.bullets) do 
        love.graphics.circle(self.mode, bullet.x, bullet.y, bullet.r)
    end
end

function Player:fire()
    local bullet = {}
    bullet.x = self.x 
    bullet.y = self.y 
    bullet.vel = 300
    bullet.r = 5
    table.insert(self.bullets, bullet)
end 

function Player:bullet_update(dt)
    for i, bullet in pairs(self.bullets) do 
        self.bullets[i].y = self.bullets[i].y - bullet.vel * dt
        if(self.bullets[i].y < 0) then
            self.bullets[i] = nil 
        end
    end
end

function Player:ship_hit()
    for r, line in pairs(ships.grid) do 
        for c, ship in pairs(line) do 
            for i, bullet in pairs(self.bullets) do 
                if((math.sqrt(math.pow(bullet.x - ship.x, 2) + math.pow(bullet.y - ship.y, 2)) < ships.size) and ship.alive) then 
                    self.bullets[i] = nil 
                    ships.grid[r][c].alive = false
                end
            end
        end
    end
end

function Player:player_hit()
    for i, bullet in pairs(ships.bullets) do 
        if(math.sqrt(math.pow(bullet.x - self.x, 2) + math.pow(bullet.y - self.y, 2)) < self.size) then 
            self.mode = 'fill'
        end
    end
end

function Player:update(dt)
    self:bullet_update(dt)
    if love.keyboard.isDown('d', 'right') then 
        self.x = self.x + self.speed * dt 
    elseif (love.keyboard.isDown('a', 'left')) then
        self.x = self.x - self.speed * dt
    end
    self:ship_hit()
end

return Player
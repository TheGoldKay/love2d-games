Enemy = {}
Enemy.__index = Enemy

function Enemy:new()
    self = setmetatable({}, self)
    self.asteroids = {}
    self.timer = 0.9
    self.clock = 0
    self:make_astro()
    return self 
end 

function Enemy:make_astro()
    local astro = {}
    if #self.asteroids < 3 or self.clock > self.timer then 
        astro.r = math.random(15, 70)
        astro.xvel = math.random(20, 80)
        if (math.random(1, 10) > 5) then 
            astro.xvel = -astro.xvel 
        end 
        astro.yvel = math.random(20, 80)
        if (math.random(1, 10) < 5) then 
            astro.yvel = -astro.yvel 
        end 
        astro.x = math.random(0, win_w)
        astro.y = math.random(0, win_h)
        table.insert(self.asteroids, astro)
        self.clock = 0
    end
end 

function Enemy:draw()
    for i, a in pairs(self.asteroids) do 
        love.graphics.circle('line', a.x, a.y, a.r)
    end
end

function Enemy:update(dt)
    self.clock = self.clock + dt 
    for i, a in pairs(self.asteroids) do 
        a.x = a.x + a.xvel * dt 
        if (a.x <= 0) then 
            a.x = win_w 
        elseif (a.x >= win_w) then 
            a.x = 0 
        end 
        a.y = a.y + a.yvel * dt 
        if(a.y <= 0) then 
            a.y = win_h
        elseif (a.y >= win_h) then 
            a.y = 0 
        end
    end
end 

return Enemy
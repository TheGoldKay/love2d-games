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
    if #self.asteroids < 3 or self.clock > self.timer and #self.asteroids < 10 then 
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
        astro.hit = 0
        table.insert(self.asteroids, astro)
        self.clock = 0

        ball = {}
        ball.b = love.physics.newBody(world, 400,200, "dynamic")  -- set x,y position (400,200) and let it move and hit other objects ("dynamic")
        ball.b:setMass(10)                                        -- make it pretty light
        ball.s = love.physics.newCircleShape(50)                  -- give it a radius of 50
        ball.f = love.physics.newFixture(ball.b, ball.s)          -- connect body to shape
        ball.f:setRestitution(0.4)                                -- make it bouncy
        local data = {"enemy", #self.asteroids}
        ball.f:setUserData(data)                                -- give it a name, which we'll access later
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
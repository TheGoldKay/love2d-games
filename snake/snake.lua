Snake = {}
Snake.__index = Snake

function Snake:init()
    self = setmetatable({}, self)
    self.box = 20
    self.xmax = love.graphics.getWidth() / self.box 
    self.ymax = love.graphics.getHeight() / self.box 
    self.body = {}
    head = {}
    head.x = self.xmax / 2
    head.y = self.ymax / 2
    self.vel = 1
    self.xvel = -self.vel
    self.yvel = 0
    self.s = 20
    self.timer = 0.2
    self.clock = 0
    self.horizontal = true 
    self.vertical = false 
    table.insert(self.body, head)
    x = head.x 
    for i = 1, 5, 1 do 
        part = {}
        part.x = head.x + i 
        part.y = head.y 
        table.insert(self.body, part)
    end 
    return self 
end 

function Snake:draw()
    for k, part in pairs(self.body) do 
        x = self.box * part.x 
        y = self.box * part.y 
        love.graphics.rectangle('fill', x, y, self.s, self.s)
    end 
end 

function Snake:move(dt)
    self.clock = self.clock + dt 
    if self.clock > self.timer then 
        self.clock = 0
        local head = self.body[1]
        head.x = head.x + self.xvel 
        head.y = head.y + self.yvel 
        if head.x <= 0 then 
            head.x = self.xmax
        elseif head.x >= self.xmax then 
            head.x = 0
        end 
        if head.y <= 0 then 
            head.y = self.ymax
        elseif head.y >= self.ymax then 
            head.y = 0
        end 
        table.insert(self.body, 1, head)
        table.remove(self.body, #self.body)
    end 
end 

return Snake
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
    self.s = 20
    self.timer = 0.2
    self.clock = 0
    self.dir = 'left'
    table.insert(self.body, head)
    x = head.x 
    for i = 1, 3, 1 do 
        part = {}
        part.x = head.x + i 
        part.y = head.y 
        table.insert(self.body, part)
    end 
    self.last = nil
    return self 
end 

function Snake:draw()
    love.graphics.setColor(1, 1, 1)
    for k, part in pairs(self.body) do 
        x = self.box * part.x 
        y = self.box * part.y 
        love.graphics.rectangle('line', x, y, self.s, self.s)
    end 
end 

function Snake:move(dt, food)
    self.clock = self.clock + dt 
    if self.clock > self.timer then 
        self.clock = 0
        local head = self.body[1]
        x, y = head.x, head.y
        if self.dir == 'left' then 
            x = x - 1
        elseif self.dir == 'right' then 
            x = x + 1
        elseif self.dir == 'up' then 
            y = y - 1
        elseif self.dir == 'down' then 
            y = y + 1
        end 
        if x < 0 then 
            x = self.xmax
        elseif x >= self.xmax then 
            x = 0
        end 
        if y < 0 then 
            y = self.ymax
        elseif y >= self.ymax then 
            y = 0
        end 
        tail = self.body[#self.body] 
        self.last = tail 
        tail.x = x
        tail.y = y
        table.insert(self.body, 1, tail)
        table.remove(self.body, #self.body)
    end 
end 

function Snake:eat(food)
    if food.x == self.body[1].x and food.y == self.body[1].y then 
        table.insert(self.body, {x=self.body[#self.body].x, y=self.body[#self.body].y})
        food:new()
    end 
    --return food 
end 

return Snake
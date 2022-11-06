Snake = {}
Snake.__index = Snake

function Snake:init()
    self = setmetatable({}, self)
    self.body = {}
    head = {}
    head.x = love.graphics.getWidth() / 2
    head.y = love.graphics.getHeight() / 2
    head.size = 20
    table.insert(self.body, head)
    return self 
end 

function Snake:draw()
    for k, part in pairs(self.body) do 
        love.graphics.rectangle('fill', part.x, part.y, part.size, part.size)
    end 
end 

return Snake
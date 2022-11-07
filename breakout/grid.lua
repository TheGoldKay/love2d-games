Grid = {}
Grid.__index = Grid 

function Grid:init()
    self = setmetatable({}, self)
    self.w = 80
    self.h = 50
    self.col = love.graphics.getWidth() / self.w
    self.rect = {}
    for i = 0, 3 do 
        for j = 0, self.col do
            box = {}
            box.x = self.w * j 
            box.y = self.h * i 
            table.insert(self.rect, box)
        end 
    end 
    return self
end 

function Grid:draw()
    for k, v in pairs(self.rect) do 
        love.graphics.rectangle('line', v.x, v.y, self.w, self.h)
    end 
end 

return Grid 
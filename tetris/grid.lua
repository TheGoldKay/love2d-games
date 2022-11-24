Grid = {}
Grid.__index = Grid 


function Grid:new()
    self = setmetatable({}, self)
    self.size = 40
    self.nrow = win_h / self.size 
    self.ncol = win_w / self.size 
    self.boxes = {}
    for row = 0, self.nrow do 
        local line = {}
        for col = 0, self.ncol do 
            y = row * self.size 
            x = col * self.size 
            table.insert(line, {x=x, y=y})
        end 
        table.insert(self.boxes, line)
    end
    return self 
end 

function Grid:draw()
    love.graphics.setColor(0, 0, 1)
    for _, line in pairs(self.boxes) do
        for _, box in pairs(line) do 
            love.graphics.rectangle('line', box.x, box.y, self.size, self.size)
        end 
    end 
    love.graphics.setColor(1, 1, 1)
end 


return Grid
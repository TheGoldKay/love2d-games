Grid = {}
Grid.__index = Grid 

function Grid:new()
    self = setmetatable({}, self)
    self.gap = love.graphics.getWidth() / 4 
    self.row = 6 
    self.col = 6
    self.size = ((love.graphics.getWidth() / 4) / 6) * 2
    return self
end

function Grid:draw()
    for r = 0, self.row - 1 do 
        for c = 0, self.col - 1 do 
            local x = c * self.size + self.gap
            local y = r * self.size + self.gap
            love.graphics.rectangle('line', x, y, self.size, self.size)
            local cx = x + self.size / 2 
            local cy = y + self.size / 2 
            love.graphics.circle('line', cx, cy, self.size/2)
        end 
    end 
end 


return Grid 
Pieces = {}
Pieces.__index = Pieces

shapes = {}
shapes["square"] = {{0, 0}, {0, 1}, {1, 0}, {1, 1}}
shapes["line"] = {{0, 0}, {1, 0}, {2, 0}, {3, 0}}

function Pieces:new()
    self = setmetatable({}, self)
    self.actual = shapes.square;
    self.size = 40;
    self.nrow = win_h / self.size 
    self.ncol = win_w / self.size 
    self.row = 0
    self.col = self.ncol / 2
    return self 
end 

function Pieces:draw()
    for i, pos in pairs(self.actual) do 
        local x, y = pos[2], pos[1]
        x = (x + self.col ) * self.size 
        y = (y + self.row ) * self.size 
        love.graphics.rectangle('fill', x, y, self.size, self.size)
    end 
end

return Pieces
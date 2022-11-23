Pieces = {}
Pieces.__index = Pieces

shapes = {}
shapes["square"] = {{0, 0}, {0, 1}, {1, 0}, {1, 1}}
shapes["line"] = {{{0, 0}, {1, 0}, {2, 0}, {3, 0}}, {{0, 0}, {0, 1}, {0, 2}, {0, 3}}}

function Pieces:new()
    self = setmetatable({}, self)
    self.shape = "line"
    self.index = 1
    self.size = 40;
    self.nrow = win_h / self.size 
    self.ncol = win_w / self.size 
    self.row = 0
    self.col = math.floor(self.ncol / 2)
    return self 
end 

function Pieces:rotate()
    len = 0
    for _, _ in pairs(shapes[self.shape]) do 
        len = len + 1
    end 
    self.index = self.index + 1
    if(self.index > len) then self.index = 1 end 
end 

function Pieces:draw()
    for i, pos in pairs(shapes[self.shape][self.index]) do 
        local x, y = pos[2], pos[1]
        x = (x + self.col ) * self.size 
        y = (y + self.row ) * self.size 
        love.graphics.rectangle('fill', x, y, self.size, self.size)
    end 
    love.graphics.setColor(0, 0, 1)
    for row = 0, self.nrow do 
        for col = 0, self.ncol do 
            y = row * self.size 
            x = col * self.size 
            love.graphics.rectangle('line', x, y, self.size, self.size)
        end 
    end
    love.graphics.setColor(1,1,1)
end

return Pieces
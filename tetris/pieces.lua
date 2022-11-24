Pieces = {}
Pieces.__index = Pieces

shapes = {}
shapes["square"] = {{{0, 0}, {0, 1}, {1, 0}, {1, 1}}}
shapes["line"] = {{{0, 0}, {1, 0}, {2, 0}, {3, 0}}, {{0, 0}, {0, 1}, {0, 2}, {0, 3}}}
shapes["z"] = {{{0, 0}, {1, 0}, {1, 1}, {2, 1}}, {{0, 0}, {0, 1}, {-1, 1}, {-1, 2}}}
shapes["s"] = {{{0, 0}, {1, 0}, {1, -1}, {2, -1}}, {{0, 0}, {0, 1}, {1, 1}, {1, 2}}}

function Pieces:new()
    self = setmetatable({}, self)
    self.shape = self:get_piece()
    self.index = 1
    self.size = 40
    self.nrow = win_h / self.size 
    self.ncol = win_w / self.size 
    self.row = 5
    self.col = math.floor(self.ncol / 2)
    self.timer = 10
    self.clock = 0
    self.out = false 
    return self 
end 

function Pieces:get_piece()
    if love.math.random(1, 10) > 5 then 
        if love.math.random(1, 10) < 5 then 
            return "square"
        else 
            return "line"
        end 
    else
        if love.math.random(1, 10) > 5 then 
            return "z"
        else 
            return "s"
        end 
    end 
end 

function Pieces:rotate()
    len = 0
    for _, _ in pairs(shapes[self.shape]) do 
        len = len + 1
    end 
    self.index = self.index + 1
    if(self.index > len) then self.index = 1 end 
end 

function Pieces:can_move()
    for _, pos in pairs(shapes[self.shape][self.index]) do 
        local x, y = pos[2], pos[1]
        x = (x + self.col ) * self.size 
        y = (y + self.row ) * self.size
        if y - 1 >= win_h - self.size * 2 then 
            return false 
        end 
    end 
    return true 
end       

function Pieces:update(dt)
    self.clock = self.clock + 1
    if(self:can_move() and self.clock > self.timer) then 
        self.row = self.row + 1 
        self.clock = 0 
        self.out = true 
    end 
    if (self.out) then 

    end
end

function Pieces:draw()
    for i, pos in pairs(shapes[self.shape][self.index]) do 
        local x, y = pos[2], pos[1]
        x = (x + self.col ) * self.size 
        y = (y + self.row ) * self.size 
        love.graphics.rectangle('fill', x, y, self.size, self.size)
    end 
end

return Pieces
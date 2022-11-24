Pieces = {}
Pieces.__index = Pieces

shapes = {}
shapes["square"] = {{{0, 0}, {0, 1}, {1, 0}, {1, 1}}}
shapes["line"] = {{{0, 0}, {1, 0}, {2, 0}, {3, 0}}, {{0, 0}, {0, 1}, {0, 2}, {0, 3}}}
shapes["z"] = {{{0, 0}, {1, 0}, {1, 1}, {2, 1}}, {{0, 0}, {0, 1}, {-1, 1}, {-1, 2}}}
shapes["s"] = {{{0, 0}, {1, 0}, {1, -1}, {2, -1}}, {{0, 0}, {0, 1}, {1, 1}, {1, 2}}}

function Pieces:new()
    self = setmetatable({}, self)
    self:make_piece()
    self.timer = 10
    self.clock = 0
    return self 
end 

function Pieces:make_piece()
    self.shape = self:get_piece()
    self.index = 1
    self.size = 20
    self.nrow = win_h / self.size 
    self.ncol = win_w / self.size 
    self.row = 1
    self.col = math.floor(self.ncol / 2)
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

function Pieces:can_move_x()
    for _, pos in pairs(shapes[self.shape][self.index]) do 
        x = pos[2] + self.col
        y = pos[1] + self.row 
        if(x == 0 or x == self.ncol - 1) then 
            return false 
        end 
        if(x - 1 > 0) then 
            if(grid.boxes[y+1][x-1].mode == 'fill') then 
                return false 
            end 
        end 
        if(x + 1 >= self.ncol) then 
            if(grid.boxes[y+1][x-2].mode == 'fill') then 
                return false 
            end
        end 
    end 
    return true 
end 

function Pieces:can_move_y()
    local y_max = 0
    local col = 0
    for _, pos in pairs(shapes[self.shape][self.index]) do 
        local y = pos[1] + self.row 
        if(y > y_max) then 
            y_max = y
            col = pos[2] + self.col 
        end 
    end 
    if(y_max + 1>= self.nrow or grid.boxes[y_max+2][col+1].mode == 'fill') then 
        grid:lay()
        self:make_piece()
        return false 
    else 
        return true 
    end  
end       

function Pieces:update(dt)
    self.clock = self.clock + 1
    if(self:can_move_y() and self.clock > self.timer) then 
        self.row = self.row + 1 
        self.clock = 0 
    end 
end

function Pieces:draw()
    love.graphics.setColor(1, 1, 1)
    for i, pos in pairs(shapes[self.shape][self.index]) do 
        local x, y = pos[2], pos[1]
        x = (x + self.col ) * self.size 
        y = (y + self.row ) * self.size 
        love.graphics.rectangle('fill', x, y, self.size, self.size)
    end 
    love.graphics.setColor(1, 1, 1)
end

return Pieces
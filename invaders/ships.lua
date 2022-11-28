Ships = {}
Ships.__index = Ships 

function Ships:new(r, c)
    self = setmetatable({}, self)
    self.row = r or 4
    self.col = c or 10
    self.x_margin = 120
    self.x_gap = 20
    self.y_margin = 20
    self.y_gap = 10
    self.size = 30
    self:make_grid()
    return self 
end 

function Ships:make_grid()
    self.grid = {}
    for r = 1, self.row do 
        local line = {}
        for c = 1, self.col do 
            table.insert(line, {row = r, col = c})
        end
        table.insert(self.grid, line)
    end
end 

function Ships:draw()
    for _, line in pairs(self.grid) do 
        for _, ship in pairs(line) do 
            local x = ship.col * self.size + self.x_margin + ship.col * self.x_gap 
            local y = ship.row * self.size + self.y_margin + ship.row * self.y_gap
            love.graphics.circle('line', x, y, self.size/2)
        end
    end
end


return Ships
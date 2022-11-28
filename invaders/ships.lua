Ships = {}
Ships.__index = Ships 

function Ships:new(r, c)
    self = setmetatable({}, self)
    self.row = r or 4
    self.col = c or 10
    self.x_margin = 120
    self.x_gap = 20
    self.velx = 1
    self.vely = 20
    self.y_margin = 20
    self.y_gap = 10
    self.size = 30
    self.timer = 0.01
    self.clock = 0
    self.dir = 'left'
    self:make_grid()
    return self 
end 

function Ships:make_grid()
    self.grid = {}
    for r = 1, self.row do 
        local line = {}
        for c = 1, self.col do 
            local x = c * self.size + self.x_margin + c * self.x_gap 
            local y = r * self.size + self.y_margin + r * self.y_gap
            table.insert(line, {x = x, y = y})
        end
        table.insert(self.grid, line)
    end
end 

function Ships:draw()
    for _, line in pairs(self.grid) do 
        for _, ship in pairs(line) do 
            love.graphics.circle('line', ship.x, ship.y, self.size/2)
        end
    end
end

function Ships:move_sideways(dt)
    self.clock = self.clock + dt 
    if(self.clock >= self.timer) then
        for r = 1, self.row do 
            for c = 1, self.col do
                if(self.dir == 'left') then
                    self.grid[r][c].x = self.grid[r][c].x - self.velx
                elseif(self.dir == 'right') then  
                    self.grid[r][c].x = self.grid[r][c].x + self.velx
                end 
            end
        end
        self.clock = 0
    end
end

function Ships:move_down()
    for r = 1, self.row do 
        for c = 1, self.col do 
            self.grid[r][c].y = self.grid[r][c].y + self.vely
        end
    end
end

function Ships:update(dt)
    self:move_sideways(dt)
    for r = 1, self.row do 
        if(self.grid[r][self.col / 2].x <= 0) then 
            self.dir = 'right'
            self.grid[r][self.col / 2].x = self.grid[r][self.col / 2].x + self.velx
            self:move_down()
        elseif(self.grid[r][self.col / 2].x >= love.graphics.getWidth()) then 
            self.dir = 'left'
            self.grid[r][self.col / 2].x = self.grid[r][self.col / 2].x - self.velx
            self:move_down()
        end
    end
end


return Ships
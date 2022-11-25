Grid = {}
Grid.__index = Grid 

function Grid:new()
    self = setmetatable({}, self)
    self.gap = love.graphics.getWidth() / 4 
    self.row = 6 
    self.col = 6
    self.size = ((love.graphics.getWidth() / 4) / 6) * 2
    self:create_grid()
    return self
end

function Grid:create_grid()
    self.list = {}
    for r = 0, self.row - 1 do 
        for c = 0, self.col - 1 do 
            local rect = {}
            local circle = {}
            local cell = {}
            local x = c * self.size + self.gap
            local y = r * self.size + self.gap
            rect.x = x 
            rect.y = y
            cell.rect = rect 
            --love.graphics.rectangle('line', x, y, self.size, self.size)
            local cx = x + self.size / 2 
            local cy = y + self.size / 2 
            circle.x = cx 
            circle.y = cy 
            circle.mode = 'line'
            cell.circle = circle 
            --love.graphics.circle('line', cx, cy, self.size/2)
            table.insert(self.list, cell)
        end 
    end 
end 

function Grid:draw()
    for _, cell in pairs(self.list) do 
        love.graphics.rectangle('line', cell.rect.x, cell.rect.y, self.size, self.size)
        love.graphics.circle(cell.circle.mode, cell.circle.x, cell.circle.y, self.size / 2)
    end 
end 


return Grid 
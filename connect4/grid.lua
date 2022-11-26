Grid = {}
Grid.__index = Grid 

function Grid:new()
    self = setmetatable({}, self)
    self.gap = love.graphics.getWidth() / 4 
    self.row = 6 
    self.col = 6
    self.size = ((love.graphics.getWidth() / 4) / 6) * 2
    self:create_grid()
    self:create_player()
    return self
end

function Grid:create_player()
    local player = {}
    player.x = self.gap + self.size / 2
    player.y = self.gap - self.size / 2
    player.r = self.size / 2
    self.player = player
end

function Grid:draw_player()
    love.graphics.circle('fill', self.player.x, self.player.y, self.player.r)
end 

function Grid:create_grid()
    self.list = {}
    for r = 0, self.row - 1 do 
        local line = {}
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
            table.insert(line, cell)
        end
        table.insert(self.list, line) 
    end 
end 

function Grid:draw()
    self:draw_player()
    for _, line in pairs(self.list) do 
        for _, cell in pairs(line) do 
            love.graphics.rectangle('line', cell.rect.x, cell.rect.y, self.size, self.size)
            love.graphics.circle(cell.circle.mode, cell.circle.x, cell.circle.y, self.size / 2)
        end
    end 
end 


return Grid 
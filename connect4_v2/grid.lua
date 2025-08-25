Grid = {}
Grid.__index = Grid

function Grid:new()
    self = setmetatable({}, self)
    self.nrow = 6
    self.ncol = 6
    self.gap = love.graphics.getWidth() / 4
    self.size = self.gap / 4 
    self.list = {}
    self:make_grid()
    self:make_player()
    self.right = 0
    self.left = 0
    return self 
end 

function Grid:make_player()
    self.player = {}
    self.player.x = 1
    self.player.y = 0
end

function Grid:player_fall()
    for i, line in pairs(self.list) do 
        if(line[self.player.x].y >= self.nrow) then 
            self.list[i][self.player.x].mode = 'fill'
        elseif(self.list[i+1][self.player.x].mode == 'fill') then 
            self.list[i][self.player.x].mode = 'fill'
        end
    end
end

function Grid:make_grid()
    for r = 1, self.nrow do 
        local line = {}
        for c = 1, self.ncol do 
            local box = {y=r, x=c, mode='line'}
            table.insert(line, box)
        end 
        table.insert(self.list, line)
    end 
end  

function Grid:check_diags()
    for y = 1, 3 do 
        c = 6
        for r = y, self.nrow do 
            y = r * self.size + self.gap 
            x = c * self.size + self.gap
            self.list[r][c].mode = 'fill' 
            --love.graphics.print(c, x+10, y+15)
            c = c - 1
        end 
    end 
    for y = 1, 3 do 
        c = 1
        for r = y, self.nrow do 
            y = r * self.size + self.gap 
            x = c * self.size + self.gap 
            self.list[r][c].mode = 'fill'
            --love.graphics.print(c, x+20, y+15)
            c = c + 1
        end 
    end 
end

function Grid:draw()
    --self:check_diags()
    love.graphics.print(self.right, 10, 10)
    love.graphics.print(self.left, 10, 20)
    local x, y = self.player.x * self.size + self.gap, self.player.y * self.size + self.gap 
    love.graphics.circle('fill', x + self.size / 2, y + self.size / 2, self.size / 2)
    for i, line in pairs(self.list) do 
        for j, box in pairs(line) do 
            local x = box.x * self.size + self.gap 
            local y = box.y * self.size + self.gap 
            love.graphics.rectangle('line', x, y, self.size, self.size)
            love.graphics.circle(box.mode, x + self.size / 2, y + self.size / 2, self.size / 2)
        end
    end
end


return Grid 
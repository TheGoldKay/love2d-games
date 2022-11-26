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
    count = 1
    for r, line in pairs(self.list) do 
        for c, box in pairs(line) do 
            x = c * self.size + self.gap 
            y = r * self.size + self.gap 
            love.graphics.print(count, x+15, y+15)
            count = count + 1
        end
    end
end

function Grid:check_diags_v1()
    for r, line in pairs(self.list) do 
        for c, box in pairs(line) do 
            if(box.mode == 'fill') then 
                step = 1
                if(r+step < self.nrow and c+step < self.ncol and self.list[r+step][c+step].mode == 'fill') then 
                    count = 1
                    while(true) do 
                        if(r+step < self.nrow and c+step < self.nrow and self.list[r+step][c+step].mode == 'fill') then 
                            count = count + 1
                            self.right = count
                        else 
                            break
                        end
                        step = step + 1
                        if (count == 4) then 
                            love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
                        end
                    end
                elseif(r-step >= 1 and c-step >= 1 and self.list[r-step][c-step].mode == 'fill') then 
                    count = 1
                    while(true) do 
                        if(r-step >= 1 and c-step >= 1 and self.list[r-step][c-step].mode == 'fill') then 
                            count = count + 1
                            self.left = count 
                        else 
                            break
                        end
                        step = step - 1
                        if(count == 4) then 
                            love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
                        end
                    end

                end
            end 
        end
    end
end

function Grid:draw()
    c = 1
    for r, line in pairs(self.list) do 
        y = r * self.size + self.gap 
        x = c * self.size + self.gap 
        love.graphics.print(c, x+15, y+15)
        c = c + 1
    end 
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
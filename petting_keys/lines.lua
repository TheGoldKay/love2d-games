local color = require 'color'
local settings = require 'conf'

local lines = {
    color = "#1E90FF",
    num_lines = 4,
    thickness = 5
}


function lines:makeLines(count)
    local count = count or self.num_lines
    local line_w = settings.width / count
    local win_h = settings.height
    self.lines = {}
    for i = 1, count - 1 do 
        local x1 = i * line_w
        local y1 = 0 
        local x2 = x1 
        local y2 = win_h
        local line = {x1, y1, x2, y2}
        table.insert(self.lines, line)
    end 
end 


function lines:drawLines()
    love.graphics.setColor({1,1,1}) --color:hex(self.color)
    love.graphics.setLineWidth(self.thickness)
    for i, line in ipairs(self.lines) do
        love.graphics.line(unpack(line))
    end
end

return lines
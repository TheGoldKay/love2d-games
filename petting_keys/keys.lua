local settings = require 'conf'
local helper = require 'love2d-helper/helper'
local lines = require 'lines'

local keys = {
    width = settings.width / lines.num_lines,
    height = 150,
    color = 'FA8072', -- SALMON COLOR
    light_color = 'FF91A4',
}

function keys:makeKeys()
    self.d = {
        x = 0,
        y = 0,
    }
    self.f = {
        x = self.d.x + self.width,
        y = 0,
    }
    self.j = {
        x = self.f.x + self.width,
        y = 0,
    }
    self.k = {
        x = self.j.x + self.width,
        y = 0,
    }
end

function keys:drawKeys()
    love.graphics.setColor(helper:hex(self.color))
    love.graphics.rectangle('fill', self.d.x, self.d.y, self.width, self.height)
    love.graphics.rectangle('fill', self.f.x, self.f.y, self.width, self.height)
    love.graphics.setColor(helper:hex(self.light_color))
    love.graphics.rectangle('fill', self.j.x, self.j.y, self.width, self.height)
    love.graphics.rectangle('fill', self.k.x, self.k.y, self.width, self.height)
end

return keys
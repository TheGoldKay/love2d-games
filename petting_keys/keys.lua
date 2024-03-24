local settings = require 'conf'
local helper = require 'love2d-helper/helper'
local lines = require 'lines'

local keys = {
    width = settings.width / lines.num_lines,
    height = 150,
    color = 'FA8072', -- SALMON COLOR
    light_color = 'FF91A4',
    vel = 100,
}

function keys:randY()
    return -self.height * 4 + love.math.random(0, self.height * 4)
end

function keys:makeKeys()
    love.math.setRandomSeed(love.timer.getTime()) 
    self.d = {
        x = 0,
        y = self:randY(),
        color = self.color
    }
    self.f = {
        x = self.d.x + self.width,
        y = self:randY(),
        color = self.color
    }
    self.j = {
        x = self.f.x + self.width,
        y = self:randY(),
        color = self.color
    }
    self.k = {
        x = self.j.x + self.width,
        y = self:randY(),
        color = self.color
    }
    self.list = {self.d, self.f, self.j, self.k}
end

function keys:update(dt)
    for i, key in ipairs(self.list) do 
        key.y = key.y + self.vel * dt
        if key.y > settings.height then
            key.y = self:randY()
        end
    end
end




function keys:drawKeys()
    love.graphics.setColor(helper:hex(self.d.color))
    love.graphics.rectangle('fill', self.d.x, self.d.y, self.width, self.height)
    love.graphics.setColor(helper:hex(self.f.color))
    love.graphics.rectangle('fill', self.f.x, self.f.y, self.width, self.height)
    love.graphics.setColor(helper:hex(self.j.color))
    love.graphics.rectangle('fill', self.j.x, self.j.y, self.width, self.height)
    love.graphics.setColor(helper:hex(self.k.color))
    love.graphics.rectangle('fill', self.k.x, self.k.y, self.width, self.height)
end

return keys
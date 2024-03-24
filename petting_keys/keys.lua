local settings = require 'conf'
local helper = require 'love2d-helper/helper'
local lines = require 'lines'

local keys = {
    width = settings.width / lines.num_lines,
    height = 150,
    color = '1a001a', -- SALMON COLOR
    light_color = '4d004d',
    vel = 100,
    timer = 0.5,
}

function keys:randY()
    return -self.height * 4 + love.math.random(0, self.height * 4)
end

function keys:makeKey(x)
    return {
        x = x,
        y = self:randY(),
        color = self.color,
        pressed = false,
        clock = 0,
        step = 0.1,
        step_timer = 0,
    }
end 

function keys:makeKeys()
    love.math.setRandomSeed(love.timer.getTime()) 
    self.d = self:makeKey(0)
    self.f = self:makeKey(self.width)
    self.j = self:makeKey(self.width * 2)
    self.k = self:makeKey(self.width * 3)
    self.list = {['d'] = self.d, ['f'] = self.f, ['j'] = self.j, ['k'] = self.k}
end

function keys:canPress(key)
    return key.y >= settings.height - self.height - 10
end 

function keys:keyPressed(key)
    if self.list[key] and self:canPress(self.list[key]) then 
        self.list[key].pressed = true
        self.list[key].color = self.light_color
    end
end

function keys:update(dt)
    for i, key in pairs(self.list) do 
        if key.y > settings.height - self.height then
            key.pressed = true
        end
        if key.pressed then
            if key.clock > key.step_timer then 
                if key.color == self.color then
                    key.color = self.light_color
                else 
                    key.color = self.color
                end
                key.step_timer = key.step_timer + key.step
            end
            key.clock = key.clock + dt
            if key.clock > self.timer then
                key.pressed = false
                key.clock = 0
                key.y = self:randY()
                key.color = self.color
                key.step_timer = 0
            end
        else
            key.y = key.y + self.vel * dt
        end
    end
end

function keys:drawKeys()
    for i, key in pairs(self.list) do
        love.graphics.setColor(helper:hex(key.color))
        love.graphics.rectangle('fill', key.x, key.y, self.width, self.height)
    end
end

return keys
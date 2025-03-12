local settings = require 'conf'
local colors = require 'color'
local lines = require 'lines'

local keys = {
    width = settings.width / lines.num_lines,
    height = 150,
    color = '1a001a', -- SALMON COLOR
    light_color = '4d004d',
    error_color = 'ff0000',
    vel = 100,
    timer = 0.5,
    score = 0,
    gap = 20,
}

function keys:randY()
    return -self.height * 4 + love.math.random(0, self.height * 4)
end

function keys:makeKey(x)
    return {
        x = x,
        y = self:randY(),
        color = self.color,
        light_color = self.light_color,
        pressed = false,
        clock = 0,
        step = 0.1,
        step_timer = 0,
        out_bounds = false
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
    return key.y + self.height >= settings.height - self.gap and key.y + self.height <= settings.height + self.gap
end 

function keys:keyPressed(key)
    if self.list[key] and self:canPress(self.list[key]) then 
        self.list[key].pressed = true
        self.list[key].color = self.light_color
    end
end

function keys:getScore()
    return self.score 
end

function keys:setScore(key)
    if key.out_bounds then 
        self.score = self.score - 1
    else
        self.score = self.score + 1
    end
end

function keys:update(dt)
    for i, key in pairs(self.list) do 
        if key.y + self.height >= settings.height + self.gap then
            key.out_bounds = true
            key.light_color = self.error_color
        end
        if key.pressed or key.out_bounds then
            if key.clock > key.step_timer then 
                if key.color == self.color then
                    key.color = key.light_color
                else 
                    key.color = self.color
                end
                key.step_timer = key.step_timer + key.step
            end
            key.clock = key.clock + dt
            if key.clock > self.timer then
                self:setScore(key)
                key.pressed = false
                key.clock = 0
                key.y = self:randY()
                key.color = self.color
                key.out_bounds = false
                key.step_timer = 0
            end
        else
            key.y = key.y + self.vel * dt
        end
    end
end

function keys:drawKeys()
    for i, key in pairs(self.list) do
        love.graphics.setColor(colors:hex(key.color))
        love.graphics.rectangle('fill', key.x, key.y, self.width, self.height)
    end
end

return keys
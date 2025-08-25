local class = require("lib.middleclass.middleclass")
local inspect = require("lib.inspect.inspect")

local Player = class("Player")

function Player:initialize(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function Player:draw(color)
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Player:info()
    -- use inspect to display the whole class information
    print(inspect(self))
end

return Player
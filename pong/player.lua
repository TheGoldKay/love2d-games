

Player = {}

Player.__index = Player

function Player:init()
    self = setmetatable({}, self)     
    self.width = 40
    self.height = 150
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.color = {1, 1, 1}
    return self
end 

function Player:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end 

return Player

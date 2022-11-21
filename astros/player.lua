Player = {}
Player.__index = Player


function Player:new()
    self = setmetatable({}, self)
    self.x = win_w / 2
    self.y = win_h / 2
    self.r = 40
    return self 
end

function Player:draw()
    love.graphics.circle('line', self.x, self.y, self.r)
end

return Player 
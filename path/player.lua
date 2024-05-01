local Player = {}

function Player:new(name)
    local obj = {
        name = name
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

return Player
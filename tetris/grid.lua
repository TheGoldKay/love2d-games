Grid = {}
Grid.__index = Grid 


function Grid:new()
    self = setmetatable({}, self)
    return self 
end 


return Grid
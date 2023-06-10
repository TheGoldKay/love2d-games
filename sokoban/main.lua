function love.load()
    levels = require "levels"
end

function love.keypressed(key)
    if(key == "escape") then 
        love.event.quit()
    end
end
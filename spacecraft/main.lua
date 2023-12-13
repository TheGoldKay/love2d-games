local ffi = require("ffi")

function love.load()
  love.graphics.setBackgroundColor(rgb(18, 53, 36))
end

function rgb(r, g, b)
    return { r / 255, g / 255, b / 255, 0.1}
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
local settings = require "conf"

function love.load()
    love.graphics.setBackgroundColor(rbg(unpack(settings.window.bg_color)))
end

function rbg(r, g, b)
    return {r / 255, g / 255, b / 255}
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
local helper = require "love2d-helper/helper"

function love.load()
    colors = helper:colors()
    love.graphics.setBackgroundColor(colors.phthalo_green)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
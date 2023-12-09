local settings = require("conf")

function love.load()
    local desktopWidth, desktopHeight = love.window.getDesktopDimensions()
    love.window.setPosition(desktopWidth / 2 - settings.window.width / 2, 100)
    love.graphics.setBackgroundColor(rgb(18, 53, 36))
end

function rgb(r, g, b)
    return { r / 255, g / 255, b / 255 }
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
local helper = require "love2d-helper/helper"
local Player = require "player"

function love.load()
    colors = helper:colors()
    love.graphics.setBackgroundColor(colors.phthalo_green)
    player = Player("Player", 20)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
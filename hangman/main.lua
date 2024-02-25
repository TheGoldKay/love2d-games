function love.load()
    local _, _, flags = love.window.getMode()
    local width, height = love.window.getDesktopDimensions(flags.display)
    local game_w, game_h = love.graphics.getDimensions()
    local x, y = width / 2 - game_w / 2, height * 0.1
    love.window.setPosition(x, y)
    love.graphics.setBackgroundColor(color("#00c04b"))
end

function color(hex, value)
	return {tonumber(string.sub(hex, 2, 3), 16)/256, tonumber(string.sub(hex, 4, 5), 16)/256, tonumber(string.sub(hex, 6, 7), 16)/256, value or 1}
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
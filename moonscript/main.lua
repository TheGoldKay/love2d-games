local bg_color = {
	18 / 255,
	53 / 255,
	36 / 255,
}

function love.load()
	love.window.setTitle("Testing")
	love.window.setMode(800, 600, {resizable = true})
	love.graphics.setBackgroundColor(bg_color)
end


function love.keypressed(key)
	if key == "escape" then 
		love.event.quit()
	end
end
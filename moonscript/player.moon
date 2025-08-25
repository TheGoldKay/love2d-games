bg_color = {
	18 / 255,
	53 / 255,
	36 / 255,
}

love.load = ->
	love.window.setTitle("Testing")
	love.window.setMode(800, 600, {resizable = true})
	love.graphics.setBackgroundColor(bg_color)


love.keypressed = (key) ->
	if key == "escape" 
		love.event.quit()
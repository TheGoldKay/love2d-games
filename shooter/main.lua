function love.load()
    print("I'm on load")
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
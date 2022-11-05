function love.load()
    print('hell')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end 
end
----------------------------------------------------------------------------------------------------
-- Code related to keyboard interactions
----------------------------------------------------------------------------------------------------
function love.keypressed(key)

    print(key)

    if key == 'right' then
        keyRight = true
    end

    if key == 'left' then
        keyLeft = true
    end

    if key == 'up' then
        keyUp = true
    end

    if key == 'down' then
        keyDown = true
    end

    if key == 'x' then
        explode(400, 300)
    end

    if key == 'n' then
        newGame()
    end

    if key == 'space' or key == 'kp0'then
        playerPressedShootButton()
    end

    if key == 's' then 
        split(allBullets[1].x, allBullets[1].y)
    end

    if key == 'escape' then
        os.exit()
    end

end

function love.keyreleased(key)
    keyRight = false
    keyLeft = false
    keyUp = false
    keyDown = false
end

function love.update(dt)
    playerN = currentPlayer()
    if keyRight then
        playerN.angle = playerN.angle + dt * angleVel
    elseif keyLeft then
        playerN.angle = playerN.angle - dt * angleVel
    end

    if keyUp then
        playerN.force = playerN.force + dt  
    elseif keyDown then
        playerN.force = playerN.force - dt 
    end
end

Player = require('player')
Enemy = require('enemy')
wf = require('windfield')

function love.load()
    world = love.physics.newWorld(0, 0, true)  --Gravity is being set to 0 in the x direction and 200 in the y direction.
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    w = wf.newWorld(0, 0, true)
    w:setGravity(0, 0)
    player = Player:new()
    astros = Enemy:new()
    text = "Pyro Ruby"
    name1, num1 = "", ""
    name2, num2 = "", ""        
end 

function love.keypressed(key)
    if (key == 'escape') then 
        love.event.quit()
    elseif (key == 'space') then 
        player:fire()
    end 
end

function beginContact(a, b, coll)
    x, y = coll:getNormal()
    i, j = a:getUserData(), b:getUserData()
    name1, num1 = i[1], i[2]
    name2, num2 = j[1], j[2]
    if (name1 == "enemy" and name2 == "bullet") then 
        text = "Collision Detected: " .. num1 .. " " .. num2 
        --astros.asteroids[num1] = nil 
        --player.bullets[num2] = nil 
    end 
    if (name1 == "bullet" and name2 == "enemy") then 
        text = "Collision Detected: " .. num1 .. " " .. num2 
        --player.bullets[num1] = nil 
        --astros.asteroids[num2] = nil 
    end 
    --name, num = i[1], i[2]
    --love.graphics.print(i_name .. i_num, 10, 10)
    --text = text.."\n"..i[1].." colliding with "..j[1].." with a vector normal of: "..x..", "..y
end 

function bullet_astro_collision()
    for i, a in pairs(player.bullets) do 
        for j, b in pairs(astros.asteroids) do 
            if math.sqrt(math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2)) < a.r + b.r then 
                player.bullets[i] = nil 
                if b.hit == 1 then 
                    astros.asteroids[j] = nil 
                else 
                    astros.asteroids[j].r = b.r / 2 
                    astros.asteroids[j].hit = 1
                end 
            end 
        end 
    end                                                                                                                                                                                                                                                                                                 
end

function love.draw()
    player:draw()
    astros:draw()
    --love.graphics.setColor(1, 0, 0)
    love.graphics.print(text, 10, 10)
    --love.graphics.print(name1 .. num1, 10, 10)
    --love.graphics.print(name2 .. num2, 10, 30)
end

function love.update(dt)
    if string.len(text) > 768 then 
        text = ""
    end 
    world:update(dt)
    w:update(dt)
    player:update(dt)
    astros:make_astro()
    astros:update(dt)
    bullet_astro_collision()
end 
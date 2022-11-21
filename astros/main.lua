Player = require('player')
Enemy = require('enemy')

function love.load()
    player = Player:new()
    astros = Enemy:new()
end 

function love.keypressed(key)
    if (key == 'escape') then 
        love.event.quit()
    elseif (key == 'space') then 
        player:fire()
    end 
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
end

function love.update(dt)
    player:update(dt)
    astros:make_astro()
    astros:update(dt)
    bullet_astro_collision()
end 
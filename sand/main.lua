function love.load()
    grains = {} -- all grains (at the bottom not moving)
    falling = {} -- grains that are falling
    drop_timer = 1 -- drop one grain at every 'x' second
    drop_clock = 0 -- store the dt of each frame to check against timer
    step = 1
end 

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end         

function dropGrain(size)
    local grain = {}
    grain.x = love.graphics.getWidth() / 2
    grain.y = 0 
    grain.s = size or 5
    grain.vel = 100
    return grain
end 

function love.draw()
    for i, grain in ipairs(falling) do
        love.graphics.circle("fill", grain.x, grain.y, grain.s)
    end
    for i, grain in ipairs(grains) do
        love.graphics.circle("fill", grain.x, grain.y, grain.s)
    end
end

function distance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

function grain_collision(grain)
    for i, fallen in ipairs(grains) do 
        if distance(grain.x, grain.y, fallen.x, fallen.y) < grain.s + fallen.s then
            return fallen
        end
    end
    return false 
end

function reposition(grain, fallen)
    if math.floor(math.random() * 10) > 5 then 
        grain.x = fallen.x + grain.s * step
    else
        grain.x = fallen.x - grain.s * step
    end
    grain.y = fallen.y + grain.s * step
    step = step + 1
    return grain
end

function upwards()
    for i, grain in ipairs(grains) do
        grain.y = grain.y - grain.s 
    end
end

function love.update(dt)
    drop_clock = drop_clock + dt
    if drop_clock >= drop_timer then 
        table.insert(falling, dropGrain())
        drop_clock = 0
    end
    for i, grain in ipairs(falling) do
        grain.y = grain.y + grain.vel * dt
        collided = grain_collision(grain)
        if collided then
            table.remove(falling, i)
            new_grain = reposition(grain, collided)
            table.insert(grains, new_grain)
            upwards()
        end
        if grain.y > love.graphics.getHeight() then
            grain.y = love.graphics.getHeight() - grain.s
            table.remove(falling, i)
            table.insert(grains, grain)
        end
    end
end


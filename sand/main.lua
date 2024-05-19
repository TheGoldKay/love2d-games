function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    grains = {} -- all grains (at the bottom not moving)
    falling = {} -- grains that are falling
    drop_timer = 1 -- drop one grain at every 'x' second
    drop_clock = 0 -- store the dt of each frame to check against timer
end         

function dropGrain(size)
    local grain = {}
    grain.x = love.graphics.getWidth() / 2
    grain.y = 0 
    grain.s = size or 5
    grain.vel = 100
end 

function love.draw()
    for i, grain in ipairs(falling) do
        love.graphics.circle("fill", grain.x, grain.y, grain.s)
    end
    for i, grain in ipairs(grains) do
        love.graphics.circle("fill", grain.x, grain.y, grain.s)
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
        if grain.y > love.graphics.getHeight() then
            table.remove(falling, i)
        end
    end
end


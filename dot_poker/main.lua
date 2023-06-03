require "tesound"

function love.load()
    circle = make_circle()
    explosion_sprites = load_images("explosion")
    explosion_array = load_image_array("explosion")
    love.graphics.setBackgroundColor(0.15, 0.15, 0.15)
end

function love.keypressed(key)
    if (key == 'escape') then 
        love.event.quit("restart")
    end
end

function make_circle()
    circle = {}
    circle.x, circle.y = randPoint()
    circle.r = 40 -- radius
    local red, green, blue = love.math.random(), love.math.random(), love.math.random()
    circle.color = {red, green, blue}
    return circle 
end

function load_image_array(dir_name)
    local explosion = love.filesystem.getDirectoryItems(dir_name)
    local sprites = {}
    for i = 1, #explosion do
        sprites[i] = dir_name .. "/" .. explosion[i]
    end
    return love.graphics.newArrayImage(sprites)
end 

function load_images(dir_name)
    local explosion = love.filesystem.getDirectoryItems(dir_name)
    local sprites = {}
    for i = 1, #explosion do
        local path = dir_name .. "/" .. explosion[i]
        sprites[i] = love.graphics.newImage(path)
    end
    return sprites
end 

function draw_sprites(sprites, x, y)
    for i, v in ipairs(sprites) do
        love.graphics.draw(v, x, y)
    end
end 

function love.mousepressed(x, y, button)
    if (button == 1) then 
        if (math.sqrt(math.pow(x - circle.x, 2) + math.pow(y - circle.y, 2)) < circle.r) then 
            TEsound.play("sounds/DeathFlash.flac", "static")
            --draw_sprites(explosion_sprites, circle.x, circle.y)
            make_circle()
        end
    end
end

function randPoint()
    x = love.math.random(WIDTH)
    y = love.math.random(HEIGHT)
    return x, y
end

function love.draw()
    love.graphics.setColor(circle.color)
    love.graphics.circle('fill', circle.x, circle.y, circle.r)
    love.graphics.setColor({1, 1, 1}) -- white
    love.graphics.circle('line', circle.x, circle.y, circle.r+1)
    for i = 1, #explosion_sprites do 
        love.graphics.drawLayer(explosion_array, i, 100, 100)
    end 
end

function love.update(dt)
    TEsound.cleanup()
end
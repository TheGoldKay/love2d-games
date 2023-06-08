function love.load()
    require "libs/tesound"
    anim8 = require "libs/anim8"
    love.graphics.setDefaultFilter("nearest", "nearest")
    circle_r = 40
    quad_w, quad_h = 222, 222
    circle = make_circle()
    explosion_img = love.graphics.newImage("art/exp.png")
    local explosion_grid = anim8.newGrid(quad_w, quad_h, explosion_img:getWidth(), explosion_img:getHeight())
    explosion_anim = anim8.newAnimation(explosion_grid(1, "1-7"), 0.05)
    love.graphics.setBackgroundColor(0.15, 0.15, 0.15)
    hit_clock = 0
    hit_timer = 0.3
end

function love.keypressed(key)
    if (key == 'escape') then 
        love.event.quit()
    end
end

function make_circle()
    circle = {}
    circle.x, circle.y = randPoint()
    circle.r = circle_r
    local red, green, blue = love.math.random(), love.math.random(), love.math.random()
    circle.color = {red, green, blue}
    return circle 
end

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end

function love.mousepressed(x, y, button)
    if (button == 1) then 
        if (math.sqrt(math.pow(x - circle.x, 2) + math.pow(y - circle.y, 2)) < circle.r) then 
            TEsound.play("sounds/DeathFlash.flac", "static")
            hit_clock = hit_timer
            exp_x, exp_y = circle.x - quad_w / 2, circle.y - quad_h / 2
            explosion_anim = explosion_anim:clone()
        end
    end
end

function randPoint()
    x = love.math.random(circle_r, WIDTH - circle_r)
    y = love.math.random(circle_r, HEIGHT - circle_r)
    return x, y
end

function draw_circle()
    love.graphics.circle('fill', circle.x, circle.y, circle.r)
    love.graphics.setColor({1, 1, 1}) -- white
    love.graphics.circle('line', circle.x, circle.y, circle.r+1)
end 

function love.draw()
    love.graphics.setColor(circle.color)
    draw_circle()
    if(hit_clock > 0) then 
        explosion_anim:draw(explosion_img, exp_x, exp_y)
    end
    if(hit_clock < 0) then 
        make_circle()
    end 
end

function love.update(dt)
    TEsound.cleanup()
    explosion_anim:update(dt)
    if(hit_clock > 0) then 
        hit_clock = hit_clock - dt 
    else 
        hit_clock = 0
    end 
end
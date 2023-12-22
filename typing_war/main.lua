local settings = require "conf"
local json = require "json/json"
local fun = require "fun/fun"
local lume = require "lume/lume"

function love.load()
    --love.graphics.setBackgroundColor(rbg(unpack(settings.window.bg_color)))
    --- font --
    teko_font = love.graphics.newFont("assets/Anton/Anton-Regular.ttf", 32)
    bg = {} -- background object
    -- index start at 1 in Lua
    bg.index = 1 -- 1 bg for testing (less brighter than previous") (3000 pixels) backgrounds to create the illusion of movement
    -- once it reaches the end of the screen, load the next background
    bg.img = love.graphics.newImage(nextBg())
    bg.prev = {} --- table with the previous background img and position
    bg.y = -bg.img:getHeight() + settings.window.height
    bg.vel = 10
    ship = {} -- ship object
    ship.img = love.graphics.newImage("assets/Emissary.png")
    ship.x = settings.window.width / 2 - ship.img:getWidth() / 2
    ship.y = settings.window.height  - ship.img:getHeight() * 2
    bullets = {} -- list of bullets (fired)
    bullets.img = love.graphics.newImage("assets/BeholderBullets.png")
    bullets.list = {} -- no bullets fired yet
    bullets.vel = 5000 -- make them fast to accompany the typing's speed
    bullets.scale = 1.7 -- make the bullets bigger 
    local json_data = love.filesystem.read("assets/wordlist.json")
    words = {} -- list of words and other data related
    words.list = json.decode(json_data) -- the whole wordlist
    words.min = 4 -- the minimum length of the word to be display 
    words.max = 7
    words.timer = {clock = 0, wait = 0.3, active = false}
    --- explostion sprite sheet --- 
    explosion = {}
    explosion.img = love.graphics.newImage("assets/explosion2.png")
    explosion.frame_width = 100 
    explosion.frame_height = 100
    explosion.row = 3
    explosion.frames = 10
    explosion.time = 0.001
    explosion.current = 1
    explosion.elapsed_time = 0
    explosion.quad = getQuad(explosion.row, explosion.frame_width, explosion.frame_height, explosion.img)
    explosion.y = settings.lettering.y + 5
    -- sound effect (explosion) -- 
    explosion.sound = {}
    explosion.sound.effect = love.audio.newSource("assets/explosion.mp3", "static")
    explosion.sound.effect:setVolume(0.3)
    explosion.sound.clock = 0
    explosion.sound.timer = 0.5
    -- start getting words --
    words.current = getWord()
end

function getQuad(row, frameWidth, frameHeight, spriteSheet)
    local quad = love.graphics.newQuad(
        0, (row - 1) * frameHeight,  -- Starting coordinates for the row
        frameWidth, frameHeight,      -- Width and height of each frame
        spriteSheet:getDimensions()   -- Dimensions of the sprite sheet
  )
  return quad
end

function getWordPair(word)
    local pair_list = {}
    for char in word:gmatch(".") do
        local letter = {}
        letter.char = char 
        letter.is_pressed = false 
        pair_list[#pair_list + 1] = letter 
    end
    return pair_list
end

function getWord()
    -- the word is a table of two value tables {char, is_pressed}
    math.randomseed(os.time())
    local list = lume.shuffle(words.list)
    for i = 1, #list do 
        local word = list[i]
        if string.len(word) >= words.min and string.len(word) <= words.max then
            table.remove(list, i)
            words.list = list
            local current = {}
            current.str = word 
            current.list = getWordPair(word)
            current.next = {char = word:sub(1, 1), index = 1}
            current.active = true
            current.x = settings.window.width / 2 - teko_font:getWidth(word) / 2
            current.y = settings.lettering.y
            return current
        end
    end
end

function nextBg()
    if bg.index <= 1 then 
        local bgImg = string.format("assets/bg%d.png", bg.index)
        bg.index = bg.index + 1
        return bgImg    
    else 
        bg.index = 1
        return string.format("assets/bg%d.png", bg.index)
    end
end

function rgb(r, g, b)
    if type(r) == "table" then
        return {r[1] / 255, r[2] / 255, r[3] / 255}
    else 
        return {r / 255, g / 255, b / 255}
    end
end

function printOutlinedText(text, color, x, y)
    -- Drawn the outline
    love.graphics.setColor(settings.lettering.outline)
    for i = -1, settings.lettering.offset.x do 
        for j = -1, settings.lettering.offset.y do
            if i ~= 0 or j ~= 0 then
                love.graphics.print(text, x + i, y + j)
            end
        end
    end
    -- Draw the main text
    love.graphics.setColor(color)
    love.graphics.print(text, x, y)
end


function displayWord(current)
    love.graphics.setFont(teko_font)
    local x, y = settings.window.width / 2 - teko_font:getWidth(current.str) / 2, 100
    local color -- the color of the text (word to be displayed)
    for i, letter in ipairs(current.list) do 
        if letter.is_pressed then
            color = rgb(settings.lettering.pressed)
            if letter.char == words.current.next.char then 
                words.current.x = x 
                words.current.y = y
            end
        else 
            color = rgb(settings.lettering.not_pressed)
        end 
        printOutlinedText(letter.char, color, x, y)
        x = x + teko_font:getWidth(letter.char)
    end
    love.graphics.setColor(settings.WHITE)
end

function drawExplosion()
    love.graphics.draw( explosion.img, 
                        explosion.quad, 
                        explosion.x, 
                        explosion.y, 
                        0, 
                        0.4, 
                        0.4)
end

function love.draw()
    love.graphics.draw(bg.img, 0, bg.y)
    if next(bg.prev) then
        love.graphics.draw(bg.prev.img, 0, bg.prev.y)
    end
    love.graphics.draw(ship.img, ship.x, ship.y)
    if #bullets.list > 0 then
        for i = 1, #bullets.list do
            love.graphics.draw(bullets.img, bullets.list[i].x, bullets.list[i].y, 0, bullets.scale, bullets.scale)
        end
    end
    displayWord(words.current)
    if explosion.active then
        drawExplosion()
    end
end

function shipFire()
    table.insert(bullets.list, {x = ship.x + ship.img:getWidth() / 6 - 5, y = ship.y + ship.img:getWidth()})
end

function getCharPos()
    local x = settings.window.width / 2 - teko_font:getWidth(words.current.str) / 2
    if words.current.next.index == 1 then
        return x - teko_font:getWidth(words.current.list[1].char)
    end
    for i = 1, #words.current.list do
        if not words.current.list[i].is_pressed or i == #words.current.list then
            return x 
        else 
            x = x + teko_font:getWidth(words.current.list[i].char)
        end
    end
end 

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "up" then 
        shipFire()
    elseif key == "space" then 
        words.current = getWord()
    elseif key == words.current.next.char and not words.timer.active then 
        shipFire()
        words.current.list[words.current.next.index].is_pressed = true 
        words.current.next.index = words.current.next.index + 1
        love.audio.stop() -- stop any playing audio from previous strokes
        love.audio.play(explosion.sound.effect)
        if #words.current.list < words.current.next.index then
            words.timer.active = true
            explosion.x = getCharPos()
            explosion.active = true 
        else 
            words.current.next.char = words.current.list[words.current.next.index].char
            explosion.x = getCharPos() - teko_font:getWidth(words.current.next.char)
            explosion.active = true
        end
    end
end

function updateExplosion(dt)
    explosion.elapsed_time = explosion.elapsed_time + dt
    if explosion.elapsed_time >= explosion.time then
      explosion.elapsed_time = 0
      explosion.current = explosion.current + 1
      if explosion.current > explosion.frames then
        explosion.current = 1  -- Loop back to the first frame
        explosion.active = false
      end
      explosion.quad:setViewport(
        (explosion.current - 1) * explosion.frame_width, (explosion.row - 1) * explosion.frame_height,
        explosion.frame_width, explosion.frame_height
      )
    end
end

function love.update(dt)
    if explosion.active then 
        updateExplosion(dt)
    end 
    if words.timer.active then
        words.timer.clock = words.timer.clock + dt
        if words.timer.clock >= words.timer.wait then
            words.timer.clock = 0
            words.timer.active = false
            words.current = getWord()
        end
    end
    bg.y = bg.y + bg.vel * dt
    if bg.y >= 0 then
        --- set the currently bg (now previous) to still be displayed till its full length
        bg.prev.img = bg.img
        bg.prev.y = bg.y 
        bg.img = love.graphics.newImage(nextBg())
        bg.y = -bg.img:getHeight() + settings.window.height
        print(bg.index)
    end
    if #bullets.list > 0 then
        for i = 1, #bullets.list do
            bullets.list[i].y = bullets.list[i].y - bullets.vel * dt
            if bullets.list[i].y < 0 then
                table.remove(bullets.list, i)
                break
            end
        end
    end
    if next(bg.prev) then 
        bg.prev.y = bg.prev.y + bg.vel * dt
        if bg.prev.y >= settings.window.height then 
            bg.prev = {}
        end
    end
end
local settings = require "conf"
local json = require "json/json"
local fun = require "fun/fun"
local lume = require "lume/lume"

function love.load()
    --love.graphics.setBackgroundColor(rbg(unpack(settings.window.bg_color)))
    bg = {} -- background object
    -- index start at 1 in Lua
    bg.index = 1 -- there are currently seven long (3000 pixels) backgrounds to create the illusion of movement
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
    local json_data = love.filesystem.read("assets/wordlist.json")
    words = {} -- list of words and other data related
    words.list = json.decode(json_data) -- the whole wordlist
    words.min = 2 -- the minimum length of the word to be display 
    words.max = 4
    word = getWord()
    --- font --
    teko_font = love.graphics.newFont("assets/Teko/Teko-VariableFont_wght.ttf", 32)
end

function getWord()
    math.randomseed(os.time())
    local list = lume.shuffle(words.list)
    for i = 1, #list do 
        local word = list[i]
        if string.len(word) >= words.min and string.len(word) <= words.max then
            table.remove(list, i)
            words.list = list
            return word
        end
    end
end

function nextBg()
    if bg.index <= 7 then 
        local bgImg = string.format("assets/bg%d.png", bg.index)
        bg.index = bg.index + 1
        return bgImg    
    else 
        bg.index = 1
        return string.format("assets/bg%d.png", bg.index)
    end
end

function rbg(r, g, b)
    return {r / 255, g / 255, b / 255}
end

function love.draw()
    love.graphics.draw(bg.img, 0, bg.y)
    if next(bg.prev) then
        love.graphics.draw(bg.prev.img, 0, bg.prev.y)
    end
    love.graphics.draw(ship.img, ship.x, ship.y)
    if #bullets.list > 0 then
        for i = 1, #bullets.list do
            love.graphics.draw(bullets.img, bullets.list[i].x, bullets.list[i].y)
        end
    end
    love.graphics.setFont(teko_font)
    love.graphics.setColor(rbg(255, 255, 0))
    love.graphics.print(word, settings.window.width / 2 - teko_font:getWidth(word) / 2, 100)
    love.graphics.setColor(rbg(255, 255, 255))
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then 
        table.insert(bullets.list, {x = ship.x + ship.img:getWidth() / 4, y = ship.y})
    end
end

function love.update(dt)
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
            bullets.list[i].y = bullets.list[i].y - 10
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
local settings = require("conf")
local love = require("love")

local ffi = require("ffi")
local bit = require("bit")
local user32 = ffi.load("user32")

function setWindowTransparent(window_name, transparent_color)
    -- make sure window_name is the same as in your love2d's conf.lua (love.conf)
    -- the default color is black (0x000000) for the trasparency mask 
    -- to use any other default color use LONG / DWORD format: Example (Bright Pink) ==> #ff007f
    --Example:  Red: 33, Green: 115 and Blue: 70 -> b * 256 * 256 + g * 256 + r
    --Result in LONG format: 70 x 256 x 256 + 115 x 256 + 33 = 4,616,993
    -- LONG: 0 to 16,777,215 (represent all colors in the RGB color model)
    if transparent_color == nil then
        transparent_color = 0
    elseif type(transparent_color) == "table" then 
        transparent_color = rgb2long(transparent_color)
    end 
    ffi.cdef[[
        typedef void* HWND;
        typedef unsigned long DWORD;
        typedef unsigned char BYTE;
        typedef bool BOOL;
        typedef long LONG;

        HWND FindWindowA(const char* lpClassName, const char* lpWindowName);
        BOOL SetWindowLongA(HWND hWnd, int nIndex, DWORD dwNewLong);
        BOOL SetLayeredWindowAttributes(HWND hWnd, DWORD crKey, BYTE bAlpha, DWORD dwFlags);
        DWORD GetWindowLongA(HWND hWnd, int nIndex); 
    ]]

    -- Constants
    local GWL_EXSTYLE = -20
    local WS_EX_LAYERED = 0x80000
    local LWA_COLORKEY = 0x1
    local ALPHA = 255

    -- Get the handle of the love2d window (its ID)
    local hwnd = user32.FindWindowA(nil, window_name)
    -- window transparency
    -- you can also set to a color you won't use in your game
    -- for that change the background color before calling this function and also use the same color below (LONG format)
    local exStyle = bit.bor(user32.GetWindowLongA(hwnd, GWL_EXSTYLE), WS_EX_LAYERED)
    user32.SetWindowLongA(hwnd, GWL_EXSTYLE, exStyle)
    -- when setting the color (love.graphics.setColor) for drawing use anything other than transparent_color
    user32.SetLayeredWindowAttributes(hwnd, transparent_color, ALPHA, LWA_COLORKEY)
end 

function love.load()
    local transparent_color = {1, 1, 1} -- change to something you won't use in your game
    love.graphics.setBackgroundColor(rgb(transparent_color)) -- background color equal transparency color mask
    setWindowTransparent(love.window.getTitle(), transparent_color)
    ship = love.graphics.newImage("assets/ship.png")
    ship2 = love.graphics.newImage("assets/ship2.png")
    block = love.graphics.newImage("assets/block.png")
    
end 

function rgb(r, g, b)
    if type(r) == "table" then
        r, g, b = unpack(r)
    end 
    return {r / 255, g / 255, b / 255} -- love2d colors range 0-1 rather than 0-255
end

function rgb2long(r, g, b)
    if type(r) == "table" then
        r, g, b = unpack(r)
    end 
    return b* 256 * 256 + g * 256 + r
end 

function love.draw()
    local winW = love.graphics.getWidth()
    local winH = love.graphics.getHeight()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(ship2, winW / 2 - ship2:getWidth() / 2, winH / 2 - ship2:getHeight() / 2)
    --love.graphics.draw(block, winW / 2 - block:getWidth() / 2, winH / 2 - block:getHeight() / 2)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
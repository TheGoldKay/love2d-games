local settings = require("conf")

local ffi = require("ffi")
local bit = require("bit")
local user32 = ffi.load("user32")

function setWindowTransparent()
    ffi.cdef[[
        typedef void* HWND;
        typedef unsigned int DWORD;
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

    -- Get the handle of the desktop window
    local hwnd = user32.FindWindowA(nil, settings.window.title)
    -- window transparency
    -- Set the desktop window to be transparent with a transparent color (RGB: 0, 0, 0 -> 0x000000)
    -- ffi.C.RGB(R, G, B) -> for colors other than black (if so make its definition on .cdef above)
    local transparentColor = 0x000000
    local currentStyle = user32.SetWindowLongA(hwnd, GWL_EXSTYLE, bit.bor(user32.GetWindowLongA(hwnd, GWL_EXSTYLE), WS_EX_LAYERED))
    user32.SetLayeredWindowAttributes(hwnd, transparentColor, 255, LWA_COLORKEY)
end 

function love.load()
    setWindowTransparent()
    ship = love.graphics.newImage("assets/ship.png")
    
end 

function rgb(r, g, b)
    return { r / 255, g / 255, b / 255}
end

function love.draw()
    local winW = love.graphics.getWidth()
    local winH = love.graphics.getHeight()
    love.graphics.draw(ship, winW / 2 - ship:getWidth() / 2, winH / 2 - ship:getHeight() / 2)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
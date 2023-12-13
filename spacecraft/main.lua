local settings = require("conf")

local ffi = require("ffi")
local user32 = ffi.load("user32.dll")

ffi.cdef[[
    typedef void* HWND;
    typedef unsigned long COLORREF;
    typedef int BOOL;
    typedef unsigned long DWORD;
    typedef long LONG_PTR;
    
    HWND GetActiveWindow();
    LONG_PTR SetWindowLongPtrA(HWND hWnd, int nIndex, LONG_PTR dwNewLong);
    BOOL SetLayeredWindowAttributes(HWND hWnd, COLORREF crKey, uint8_t bAlpha, DWORD dwFlags);
    
    static const int GWL_EXSTYLE = -20;
    static const int WS_EX_LAYERED = 0x00080000;
    static const DWORD LWA_COLORKEY = 0x00000001;
    static const DWORD LWA_ALPHA = 0x00000002;
]]

function setLove2DWindowTransparency()
    local windowHandle = user32.GetActiveWindow()
    user32.SetWindowLongPtrA(windowHandle, ffi.C.GWL_EXSTYLE, ffi.C.WS_EX_LAYERED)
    user32.SetLayeredWindowAttributes(windowHandle, 0, 0, ffi.C.LWA_ALPHA)
end

setLove2DWindowTransparency()


function rgb(r, g, b)
    return { r / 255, g / 255, b / 255, 0.1}
end

function love.draw()
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()

    -- Draw a little rectangle in the middle of the window
    love.graphics.setColor(rgb(255, 0, 0))
    love.graphics.rectangle("fill", windowWidth / 2 - 25, windowHeight / 2 - 25, 50, 50)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
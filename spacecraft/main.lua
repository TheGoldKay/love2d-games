local settings = require("conf")

local ffi = require("ffi")
local bit = require("bit")

function love.load()
    -- Define the foreign functions and types
    ffi.cdef[[
        typedef void* HWND;
        typedef unsigned int DWORD;
        typedef unsigned char BYTE;
        typedef bool BOOL;
        typedef long LONG;

        typedef struct {
            LONG left;
            LONG top;
            LONG right;
            LONG bottom;
        } RECT;

        HWND FindWindowA(const char* lpClassName, const char* lpWindowName);
        BOOL SetLayeredWindowAttributes(HWND hwnd, DWORD crKey, BYTE bAlpha, DWORD dwFlags);
        DWORD GetWindowLongA(HWND hWnd, int nIndex);
        BOOL SetWindowLongA(HWND hWnd, int nIndex, DWORD dwNewLong);
        BOOL RedrawWindow(HWND hWnd, const RECT *lprcUpdate, void* hrgnUpdate, DWORD flags);

        static const int GWL_EXSTYLE = -20;
        static const int WS_EX_LAYERED = 0x00080000;
        static const int LWA_ALPHA = 0x2;
        static const int RDW_INVALIDATE = 0x1;
        static const int RDW_ALLCHILDREN = 0x80;
    ]]

    -- Load the library
    local user32 = ffi.load("User32")

    -- Find the window by its title
    local window = user32.FindWindowA(nil, settings.window.title)
    print("window: ", window)
    -- Set the window to be a layered window
    local exStyle = user32.GetWindowLongA(window, ffi.C.GWL_EXSTYLE)
    print("exStyle: ", exStyle)
    user32.SetWindowLongA(window, ffi.C.GWL_EXSTYLE, bit.bor(exStyle, ffi.C.WS_EX_LAYERED))

    -- Set the window's transparency to 100%
    local COLORREF = 0
    local alpha = 50
    user32.SetLayeredWindowAttributes(window, COLORREF, alpha, ffi.C.LWA_ALPHA)

    -- Redraw the window's contents (JUST FOR TESTING - IT MAY WORK OUT A WAY TO TAKE THIS OUT)
    --local flags = bit.bor(ffi.C.RDW_INVALIDATE, ffi.C.RDW_ALLCHILDREN)
    --print("flags: ", flags)
    --user32.RedrawWindow(window, nil, nil, flags)
    ship = love.graphics.newImage("assets/ship.png")
    canvas = love.graphics.newCanvas()
    love.graphics.setCanvas(canvas)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(ship, 500, 500)
    love.graphics.setCanvas()
end 

function rgb(r, g, b)
    return { r / 255, g / 255, b / 255}
end

function love.draw()
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()

    -- Draw a little rectangle in the middle of the window
   -- love.graphics.setColor(rgb(255, 0, 0))
    --love.graphics.rectangle("fill", windowWidth / 2 - 25, windowHeight / 2 - 25, 50, 50)
    -- Set the color to red with 50% transparency
    --love.graphics.setColor(1, 0, 0, 1)

    -- Draw a rectangle with the current color
    --love.graphics.rectangle("fill", 50, 50, 100, 100)
    --love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.draw(ship, 500, 500)

    love.graphics.draw(canvas, 50, 50)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
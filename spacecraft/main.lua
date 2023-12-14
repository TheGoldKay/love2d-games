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
        typedef void* HDC;
        typedef void* HBITMAP;
        typedef void* HGDIOBJ;
        typedef unsigned int UINT;
    
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
    
        HDC GetDC(HWND hWnd);
        HDC CreateCompatibleDC(HDC hdc);
        HBITMAP CreateBitmap(int nWidth, int nHeight, UINT nPlanes, UINT nBitCount, const void* lpBits);
        HGDIOBJ SelectObject(HDC hdc, HGDIOBJ hgdiobj);
        BOOL PatBlt(HDC hdc, int nXLeft, int nYLeft, int nWidth, int nHeight, DWORD dwRop);
        BOOL DeleteObject(HGDIOBJ hObject);
        BOOL DeleteDC(HDC hdc);
        BOOL ReleaseDC(HWND hWnd, HDC hdc);
    
        static const int GWL_EXSTYLE = -20;
        static const int WS_EX_LAYERED = 0x00080000;
        static const int LWA_ALPHA = 0x2;
        static const int RDW_INVALIDATE = 0x1;
        static const int RDW_ALLCHILDREN = 0x80;
        static const int LWA_COLORKEY = 0x1;
    ]]
    local user32 = ffi.load("User32")
    local gdi32 = ffi.load("Gdi32")
    local width = settings.window.width
    local height = settings.window.height
    local BLACKNESS = 0x000000
    -- Find the window by its title
    local window = user32.FindWindowA(nil, settings.window.title)
    print("Found window: " .. tostring(window))
    -- Create a device context for the window
    local hdc = user32.GetDC(window)
    
    -- Create a compatible device context for the mask image
    local mask_dc = gdi32.CreateCompatibleDC(hdc)
    
    -- Create a bitmap for the mask image
    local mask_bitmap = gdi32.CreateBitmap(width, height, 1, 1, nil)
    
    -- Select the mask bitmap into the mask device context
    local old_mask_bitmap = gdi32.SelectObject(mask_dc, mask_bitmap)
    
    -- Draw the mask image
    gdi32.PatBlt(mask_dc, 0, 0, width, height, BLACKNESS)
    
    -- Set the window to be a layered window
    local exStyle = user32.GetWindowLongA(window, ffi.C.GWL_EXSTYLE)
    user32.SetWindowLongA(window, ffi.C.GWL_EXSTYLE, bit.bor(exStyle, ffi.C.WS_EX_LAYERED))
    
    -- Set the window's transparency using the mask image
    local COLORREF = 0
    local alpha = 50
    user32.SetLayeredWindowAttributes(window, COLORREF, alpha, bit.bor(ffi.C.LWA_ALPHA, ffi.C.LWA_COLORKEY))
    
    -- Redraw the window's contents
    local flags = bit.bor(ffi.C.RDW_INVALIDATE, ffi.C.RDW_ALLCHILDREN)
    user32.RedrawWindow(window, nil, nil, flags)
    
    -- Clean up
    gdi32.SelectObject(mask_dc, old_mask_bitmap)
    gdi32.DeleteObject(mask_bitmap)
    gdi32.DeleteDC(mask_dc)
    user32.ReleaseDC(window, hdc)
    
    ship = love.graphics.newImage("assets/ship.png")
    love.graphics.setBackgroundColor(0, 0, 0, 0)
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
   -- love.graphics.setColor(1, 0, 0, 1)

    -- Draw a rectangle with the current color
    love.graphics.rectangle("fill", 50, 50, 100, 100)
    --love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(ship, 100, 100)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
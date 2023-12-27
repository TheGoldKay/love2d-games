import win32gui
import win32api
import win32con
import ctypes
from ctypes import wintypes
import json 

# Define the FindWindow function signature
FindWindow = ctypes.windll.user32.FindWindowW
FindWindow.argtypes = [wintypes.LPCWSTR, wintypes.LPCWSTR]
FindWindow.restype = wintypes.HWND

def setWindowTransparent(hwnd, transparent_color):
    r, g, b = transparent_color
    win32gui.SetWindowLong(hwnd, win32con.GWL_EXSTYLE, win32gui.GetWindowLong(
                        hwnd, win32con.GWL_EXSTYLE) | win32con.WS_EX_LAYERED)
    # This will set the opacity and transparency color key of a layered window
    win32gui.SetLayeredWindowAttributes(hwnd, win32api.RGB(r, g, b), 255, win32con.LWA_COLORKEY)

with open("game_data.json", 'r') as f:
    data = json.load(f)
    
background_color = (data['rgb']['r'], data['rgb']['g'], data['rgb']['b'])
window_name = data['title']

window_handle = FindWindow(None, window_name) # Find the window handle (its ID pointer)
# the window must be already runnning (the effect is applied in real time)
setWindowTransparent(window_handle, background_color)
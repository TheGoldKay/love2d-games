settings = {
    window = {
        title = "Typing Warrior",
        width = 400,
        height = 700,
        bg_color = {191, 64, 191},
    },
    lettering = {
        pressed = {255, 0, 0},
        not_pressed = {255, 255, 0},
        outline = {0, 0, 0},
        offset = {x = 2, y = 4},
    },  
    WHITE = {1, 1, 1},
}

function love.conf(t)
    t.window.title = settings.window.title
    t.window.width = settings.window.width 
    t.window.height = settings.window.height 
end

return settings
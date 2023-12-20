settings = {
    window = {
        title = "Typing Warrior",
        width = 400,
        height = 700,
        bg_color = {0, 163, 108},
    }
}

function love.conf(t)
    t.window.title = settings.window.title
    t.window.width = settings.window.width 
    t.window.height = settings.window.height 
end

return settings
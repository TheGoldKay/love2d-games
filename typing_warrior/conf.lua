settings = {
    window = {
        title = "Typing Warrior",
        width = 400,
        height = 630,
        bg_color = {191, 64, 191},
    }
}

function love.conf(t)
    t.window.title = settings.window.title
    t.window.width = settings.window.width 
    t.window.height = settings.window.height 
end

return settings
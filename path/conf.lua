local settings = {
    win_w = 400,
    win_h = 700,
    box_size = 40,
}

function love.conf(t)
    t.window.title = "Path"
    t.window.width = settings.win_w
    t.window.height = settings.win_h
end

return settings
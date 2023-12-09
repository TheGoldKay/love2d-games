local settings = {
    window = {
        title = "Spacecraft",
        width = 400,
        height = 400
    }
}

function love.conf(t)
    t.window.title = settings.window.title
    t.window.width = settings.window.width
    t.window.height = settings.window.height
end 

return settings 
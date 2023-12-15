local settings = {
    window = {
        title = "Spacecraft",
        width = 500,
        height = 500,
        borderless = true, 
        fullscreen = false,
    }, 
    color = {
        deep_green = {18, 53, 36} -- phthalo green
    }
}

function love.conf(t)
    if settings.window.fullscreen then
        t.window.fullscreen = true
    else 
        t.window.width = settings.window.width
        t.window.height = settings.window.height
    end
    t.window.title = settings.window.title
    --t.window.borderless = settings.window.borderless
end 

return settings 
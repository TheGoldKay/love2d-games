local settings = {
    title = "Pet Keys",
    width = 400,
    height = 600,
    bg_color = '#1A4146',
}

function love.conf(t)
    t.window.title = settings.title
    t.window.height = settings.height
    t.window.width = settings.width
    t.console = false -- on for debbugging
end

return settings
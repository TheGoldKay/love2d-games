settings = {
    title = "Pet Keys",
    width = 400,
    height = 600
}
function love.conf(t)
    t.window.title = settings.title
    t.window.height = settings.width
    t.window.width = settings.height
end
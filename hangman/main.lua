local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("libs/json")

function get_word(word_len, category)
    word_len = word_len or 4
    category = category or "animal"
    -- URL of the API endpoint
    local url = "https://www.wordgamedb.com/api/v1/words/?category=" .. category .. "&numLetters=" .. word_len

    -- Table to store the response body
    local response_body = {}

    -- Make the API request
    local res, status_code, response_headers = http.request{
        url = url,
        method = "GET", -- Change this to "POST", "PUT", etc. if needed,
        sink = ltn12.sink.table(response_body)
    }

    -- Check if the request was successful
    if status_code == 200 then
        local response = json.decode(response_body[1])
        local index = math.random(1, response_size(response))
        local res = response[index]
        return {word = res["word"], category = res["category"], hint = res["hint"], len = res["numLetters"]}
    else
        error("Error: " .. status_code)
    end
end

function response_size(response)
    local count = 0
    for _ in pairs(response) do
        count = count + 1
    end
    return count 
end

function love.load()
    local _, _, flags = love.window.getMode()
    local width, height = love.window.getDesktopDimensions(flags.display)
    local game_w, game_h = love.graphics.getDimensions()
    local x, y = width / 2 - game_w / 2, height * 0.1
    love.window.setPosition(x, y)
    love.graphics.setBackgroundColor(color("#00c04b"))
    categories = {"animal", "sports", "fruit", "tool"}
    local word = get_word(4, "animal")
    print(word.word, word.category, word.hint, word.len)
end

function color(hex, value)
	return {tonumber(string.sub(hex, 2, 3), 16)/256, 
            tonumber(string.sub(hex, 4, 5), 16)/256, 
            tonumber(string.sub(hex, 6, 7), 16)/256, 
            value or 1}
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
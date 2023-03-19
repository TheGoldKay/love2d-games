-- Define the Tetris pieces as tables of coordinates
local pieces = {
    -- I piece
    {
      {0, 1},
      {1, 1},
      {2, 1},
      {3, 1}
    },
    
    -- J piece
    {
      {0, 2},
      {0, 1},
      {1, 1},
      {2, 1}
    },
    
    -- L piece
    {
      {2, 2},
      {0, 1},
      {1, 1},
      {2, 1}
    },
    
    -- O piece
    {
      {1, 2},
      {2, 2},
      {1, 1},
      {2, 1}
    },
    
    -- S piece
    {
      {1, 2},
      {2, 2},
      {0, 1},
      {1, 1}
    },
    
    -- T piece
    {
      {1, 2},
      {0, 1},
      {1, 1},
      {2, 1}
    },
    
    -- Z piece
    {
      {0, 2},
      {1, 2},
      {1, 1},
      {2, 1}
    }
}

function love.load()
    piece_size = 20
    index = 1
end

function love.keypressed(key)
    if (key == 'space') then 
        index = math.random(1, 7)
    end
end 

function love.draw()
    -- Example usage: get the coordinates of the I piece
    local coords = pieces[index]
    for i = 1, #coords do
        x, y = coords[i][1], coords[i][2]
        love.graphics.rectangle('fill', 300 + x * piece_size , 300 + y * piece_size, piece_size, piece_size)
    end
end 
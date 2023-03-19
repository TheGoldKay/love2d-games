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
    piece_size = 30
    index = 1
end

function makePiece()
end 

function love.keypressed(key)
    if (key == 'space') then 
        index = math.random(1, 7)
    elseif (key == 'escape') then 
        love.event.quit()
    elseif (key == 's') then 
        pieces[index] = rotatePiece(pieces[index])
    end
end 

function rotatePiece(piece)
    -- Get the center of the piece
    local cx, cy = 0, 0
    for i = 1, #piece do
      cx = cx + piece[i][1]
      cy = cy + piece[i][2]
    end
    cx = cx / #piece
    cy = cy / #piece
    
    -- Rotate each block around the center
    for i = 1, #piece do
      local x, y = piece[i][1], piece[i][2]
      local dx, dy = x - cx, y - cy
      piece[i][1] = cx + dy
      piece[i][2] = cy - dx
    end
    return piece 
end
  

function love.draw()
    -- Example usage: get the coordinates of the I piece
    local coords = pieces[index]
    for i = 1, #coords do
        x, y = coords[i][1], coords[i][2]
        love.graphics.rectangle('fill', 50 + x * piece_size , 300 + y * piece_size, piece_size, piece_size)
    end
end 
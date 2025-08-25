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
  piece = makePiece()
end

function makePiece()
  piece = {}
  piece.size = 30
  piece.shape = pieces[math.random(1, 7)]
  return piece 
end 

function love.keypressed(key)
    if (key == 'escape') then 
        love.event.quit()
    elseif (key == 's') then 
        piece.shape = rotatePiece(piece.shape)
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
    for i = 1, #piece.shape do
        x, y = piece.shape[i][1], piece.shape[i][2]
        love.graphics.rectangle('fill', 50 + x * piece.size , 300 + y * piece.size, piece.size, piece.size)
    end
end 
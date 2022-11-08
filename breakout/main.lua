Pallet = require('pallet')
Ball = require('ball')
Grid = require('grid')

function love.load()
    pallet = Pallet:init()
    ball = Ball:init()
    grid = Grid:init()
end 

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end 
end 

function love.draw()
    pallet:draw()
    ball:draw()
    grid:draw()
end 

function circle_and_rectangle_overlap(cx, cy, cr, rx, ry, rw, rh)
	local circle_distance_x = math.abs(cx - rx - rw/2)
	local circle_distance_y = math.abs(cy - ry - rh/2)

	if circle_distance_x > (rw/2 + cr) or circle_distance_y > (rh/2 + cr) then
		return false
	elseif circle_distance_x <= (rw/2) or circle_distance_y <= (rh/2) then
		return true
	end

	return (math.pow(circle_distance_x - rw/2, 2) + math.pow(circle_distance_y - rh/2, 2)) <= math.pow(cr, 2)
end
 
function love.update(dt)
    pallet:move(dt)
    ball:move(dt, pallet)
    cx = ball.x + ball.r 
    cy = ball.x + ball.r 
    if circle_and_rectangle_overlap(ball.x, ball.y, ball.r, pallet.x, pallet.y, pallet.w, pallet.h) then 
        ball.yvel = -ball.yvel 
    end 
end 
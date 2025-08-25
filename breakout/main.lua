Pallet = require('pallet')
Ball = require('ball')
Grid = require('grid')

function love.load()
    pallet = Pallet:init()
    ball = Ball:init()
    grid = Grid:init()
    stop = 1
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

function circle_and_rectangle_overlap1(circle, rect)
    circleDistance = {}
    circleDistance.x = math.abs(circle.x - rect.x)
    circleDistance.y = math.abs(circle.y - rect.y)

    if (circleDistance.x > (rect.w/2 + circle.r)) then return false end 
    if (circleDistance.y > (rect.h/2 + circle.r)) then return false end 

    if (circleDistance.x <= (rect.w/2)) then return true end 
    if (circleDistance.y <= (rect.h/2)) then return true end 

    cornerDistance_sq = (circleDistance.x - rect.w/2)^2 + (circleDistance.y - rect.h/2)^2

    return cornerDistance_sq <= (circle.r^2)
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
    if stop == 0 then 
        ball:move(dt, pallet)
    else 
        stop = stop - 1
    end 
    cx = ball.x + ball.r 
    cy = ball.x + ball.r 
    if circle_and_rectangle_overlap(ball.x, ball.y, ball.r, pallet.x, pallet.y, pallet.w, pallet.h) then 
    --if circle_and_rectangle_overlap(ball, pallet) then 
        ball.yvel = -ball.yvel 
        stop = 1
        ball:move(dt, pallet)
    end 
    i = 1
    for k, val in pairs(grid.rect) do 
        if circle_and_rectangle_overlap(ball.x, ball.y, ball.r, val.x, val.y, val.w, val.h) then 
        --if circle_and_rectangle_overlap(ball, val) then 
            ball.yvel = -ball.yvel
            table.remove(grid.rect, i)
        end 
        i = i + 1
    end 
end 
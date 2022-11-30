local playerX = 300
local playerY = 300
local particleSystem

function love.load()
	-- Create a simple image with a single white pixel to use for the particles.
	-- We could load an image from the hard drive but this is just an example.
	local imageData = love.image.newImageData(1, 1)
	imageData:setPixel(0,0, 1,1,1,1)

	local image = love.graphics.newImage(imageData)

	-- Create and initialize the particle system object.
	particleSystem = love.graphics.newParticleSystem(image, 1000)
	particleSystem:setEmissionRate(150)
	particleSystem:setParticleLifetime(.7, 1)
	particleSystem:setSizes(2)
	particleSystem:setSpread(2*math.pi)
	particleSystem:setSpeed(20, 30)
	particleSystem:setColors(1,1,1,1, 1,1,0,1, 1,0,0,1, 1,0,0,0)
end

function love.update(dt)
	-- Update player position.
	local moveSpeed = 250
	if love.keyboard.isDown("left")  then  playerX = playerX - moveSpeed * dt  end
	if love.keyboard.isDown("right") then  playerX = playerX + moveSpeed * dt  end
	if love.keyboard.isDown("up")    then  playerY = playerY - moveSpeed * dt  end
	if love.keyboard.isDown("down")  then  playerY = playerY + moveSpeed * dt  end

	-- Move the particle system's particle emitter to the player's position so
	-- that newly spawned particles appear where the player currently is.
	particleSystem:moveTo(playerX, playerY)
	particleSystem:update(dt) -- This performs the simulation of the particles.
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.print("Arrow keys to move", 10, 10)

	-- Draw the particle system. Note that we don't need to give the draw()
	-- function any coordinates here as all individual particles have their
	-- own position (which only the particleSystem object knows about).
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(particleSystem)

	-- Draw the player.
	love.graphics.setColor(0, .5, 1)
	love.graphics.circle("fill", playerX, playerY, 10)
end
--[[

Update Oct 1 2012
	This needs to bo a voxel engine that displays in 2D but that has elements of 3D built itno it.
	Specifically the engine needs to be able to handle depth. so tha terain can have more variety.
	The depth will be fairly simple things, but this will allow for water and for mountains, the  kind of variety
	that will really make the world look interesting


Key tasks

	-2D voxel engine
	-Creation of simple rectangular shapes with mouse
	-Simplification of complex compound shapes
	-Pattern continuation

I would like this progrom to replicate the basic functionality of prison builder in that it should 
allow the player to select and designate regions that then take on some physical structure.

I would also like this tool to allow for more irregular shapes and reapeated patterns. The idea is that this tool
should allow for -eventually- automatic generation of interesting terrain.

This terrain can then be populated by other - ai and player driven - units.

Generation this way will essentially be vovel based which will allow for destruction of the generated content by
the more organir portions of the game.






]]--


function love.load()

	onScreen = {}
	

	for x = 1, 100 do
		for y = 1, 100 do
			local voxel = {}
			voxel.size = 2
			voxel.x, voxel.y = x * voxel.size, y * voxel.size
			voxel.red, voxel.green, voxel.blue, voxel.alpha = x * 1, y * 2, x * 3, 255
			table.insert(onScreen, voxel)
		end
	end
end

function love.update(dt)
	for i, v in ipairs(onScreen) do
		if v.red < 255 then
			v.red = v.red + 1*dt
		else
			v.red = 0
		end
		if v.green < 255 then
			v.green = v.green + 1
		else
			v.green = 0
		end
		if v.blue < 255 then
			v.blue = v.blue + 1
		else
			v.blue = 0
		end
			
	end
end

function love.draw()
	--love.graphics.setColor(255, 255, 255, 255)


	for i, v in ipairs(onScreen) do
		love.graphics.setColor(v.red, v.green, v.blue, v.alpha)
		love.graphics.rectangle("fill", v.x, v.y, v.size, v.size)
	end

end
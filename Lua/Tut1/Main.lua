function love.load()
	dude = {}
	dude.numSides = 3
	dude.x = 0
	dude.y = 0
	dude.size = 10

	hits = 0
end
function love.update(dt)
	if love.keyboard.isDown("e") then
		dude.x = dude.x + 10
	end
	if love.keyboard.isDown("a")then
			dude.x = dude.x - 10
	end
	if love.keyboard.isDown(",") then
			dude.y = dude.y - 10
	end
	if love.keyboard.isDown("o") then
		dude.y = dude.y + 10
	end

end

function love.draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.circle("fill",dude.x, dude.y, dude.size , dude.numSides)
	love.graphics.print(dude.numSides,0,0)
	love.graphics.print(hits, 10, 10)

end
 
function love.keyreleased(key)
	if key == " " then
		dude.numSides = dude.numSides + 1
	end
end


function love.mousepressed(x, y, button)
	if button == "l" and CheckCollision(x,y,1,1, dude.x, dude.y, dude.size, dude.size) then
		hits = hits + 1
	end

end


function CheckCollision(ax1, ay1, aw, ah, bx1, by1, bw, bh)
	local ax2, ay2, bx2, by2 = ax1 +aw , ay1 + ah, bx1 +bw, by1 +bh
	return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end
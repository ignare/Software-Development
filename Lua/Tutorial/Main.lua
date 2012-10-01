function love.load()
	hero ={}
	hero.x = 300
	hero.y = 450
	hero.speed =100
	hero.shots = {}

	--Create a series of bad guys
	enemies = {}
	for i = 0, 7 do
		enemy = {}
		enemy.width = 40
		enemy.height = 20
		enemy.x = i * (enemy.width + 60) + 100
		enemy.y = enemy.height + 100
		table.insert(enemies, enemy)
	end
end

function love.update(dt)
	if love.keyboard.isDown("left") then
		hero.x = hero.x - hero.speed*dt
	elseif love.keyboard.isDown("right")then
		hero.x = hero.x + hero.speed*dt
	end

	--Keep hero on screen
	if hero.x > 800 then
		hero.x = -29
	end
	if hero.x < -30 then
		hero.x = 800
	end

	--Let enemies fall
	for i, v in ipairs(enemies) do
		v.y = v.y + dt
		if v.y > 465 then
			love.graphics.print("You lose!", 400, 400)
		end
	end

	--Let bullets rise
	local remEnemy ={}
	local remShot = {}

	for i, v in ipairs(hero.shots) do
		v.y = v.y - dt * 100
		if v.y < 0 then
			table.insert(remShot, i)
		end
		for ii, vv in ipairs(enemies) do
			if CheckCollision(v.x, v.y, 2, 5, vv.x, vv.y, vv.width, vv.height) then
				table.insert(remEnemy, ii)
				table.insert(remShot, i)
			end
		end
	end

	for i, v in ipairs(remEnemy) do
		table.remove(enemies, v)
	end
	for i, v in ipairs(remShot) do
		table.remove(hero.shots, v)
	end
end

function love.draw()
	--ground (red, green, blue, alpha)
	love.graphics.setColor(0,255,0,255)
	love.graphics.rectangle("fill",0,465,800,150)
	--sky
	love.graphics.setColor(0,0,255,100)
	love.graphics.rectangle("fill",0,0,800,465)
	--hero
	love.graphics.setColor(255,255,0,255)
	love.graphics.rectangle("fill", hero.x, hero.y, 30, 15)

	--enemies
	love.graphics.setColor(0,255,255,255)
	for i,v in ipairs(enemies) do
		love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
	end

	--bullets
	love.graphics.setColor(255,255,255,255)
	for i, v in ipairs(hero.shots) do
		love.graphics.rectangle("fill", v.x, v.y, 2,5)
	end

end

function shoot()
	local shot = {}
	shot.x = hero.x + 15
	shot.y =hero.y
	table.insert(hero.shots, shot)
end

function love.keyreleased(key)
	if (key == " ") then
		shoot()
	end
end

function CheckCollision(ax1, ay1, aw, ah, bx1, by1, bw, bh)
	local ax2, ay2, bx2, by2 = ax1 +aw , ay1 + ah, bx1 +bw, by1 +bh
	return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end


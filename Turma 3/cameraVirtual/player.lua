local tecladoScript = require ("teclado")

local player = {}

function player.novo (x, y)

	local sprite = graphics.newImageSheet ("player-sprite-sheet.png", 
		{width= 90, height= 95, numFrames= 12})

	local animacao = 
			{
				{name= "parado", start= 1, count= 3, time= 300, loopCount= 0},
				{name= "correndo", start= 5, count= 8, time= 500, loopCount= 0}
			}

	local player = display.newSprite (sprite, animacao)
	player.x = x
	player.y = y
	player.id = "Player"
	player.direcao = "parado"

	player:setSequence ("parado")
	player:play()

	player.numeroPulo = 0

	physics.addBody (player, "dynamic", {friction= 2, 
		box= {x=0, y=0, halfWidth=30, halfHeight=40, angle=0}} )
	player.isFixedRotation = true 

	tecladoScript.novo (player)

	local function onCollision (self, event)
		if event.phase == "began" then
			-- verifico quem é o outro objeto envolvido na colisão através do event.other
			-- other significa outro 
			if event.other.id == "chao" then
				self.numeroPulo = 0

			elseif event.other.id == "inimigo" then
				print( "colidiu com inimigo" )

				local topo_inimigo = event.other.y - ( event.other.height/2 )
				print( "topo inimigo: " .. topo_inimigo)
				print( "Player Y: " .. self.y )
				
				if self.y <= topo_inimigo then
					display.remove( event.other )
					self:setLinearVelocity( 0, -300 )
				end

			elseif event.other.id == "moeda" then
				display.remove( event.other )

			end

		end
	end
	player.collision = onCollision
	player:addEventListener( "collision" )


	return player
	end 

return player 

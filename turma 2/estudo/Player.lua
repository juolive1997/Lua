TecladoClasse = require ("Teclado")

local Player = {}

function  Player.novo (x, y, hud )

	physics.start ()
	local vidas = 3
	local vidasText = display.newText ("Vidas:" .. vidas, 350, 30, Arial, 50)

	local playerSprite = graphics.newImageSheet ("imagens/playerFem.png", {width= 192, height= 256, numFrames=45 })

	-- Calculo do tamanho do frame: 
		-- width= largura total da imagem / (dividido) pela quantidade de frames na horizontal.
		-- height= altura total da imagem / (dividido) pela quantidade de frames na vertical. 

	local playerAnimacao = { 
		{name="parado", start=1, count=1, time=1000, loopCont=0 }, 
		{name="andando", start=37, count=8, time=1000, loopCont=0},
		{name="pulo", start=2, count=3, time=1000, loopCont=0}
	}

	local player =display.newSprite (playerSprite, playerAnimacao)
	player.x = x
	player.y = y 

	player.id= "Player"
	player.direcao= "parado"

	player:setSequence ("parado")
	player:play ()

	player.numeroPulo = 0

	physics.addBody(player, "dynamic", {friction=2, box= {x=0, y=0, halfWidth=80, halfHeight=130, angle=0}})
	player.isFixedRotation = true -- player possui rotação fixa.
		
	TecladoClasse.novo (player)

	local function onCollision (self, event)

		if event.phase == "began" then 

			if event.other.id == "chao" then 
				self.numeroPulo = 0

			elseif event.other.id == "projetilInimigo" then 
				self.vidas = vidas - 1
				vidas= vidas-1
				vidasText.text = "Vidas: " .. vidas 
				-- display.remove "projetilInimigo"
					if (vidas == 0) then 
						display.remove (player)
						display.remove "projetilInimigo"


						local restart = display.newText ("Restart", display.contentCenterX, display.contentCenterY, Arial, 100)

					end -- fecha o if vidas == 0 

				local topoInimigo = event.other.y - (event.other.height/2)
				print ("topo inimigo: " .. topoInimigo)
				print ("Player Y: " .. self.y )

			if self.y <= topoInimigo then 
				display.remove (event.other)
				self:setLinearVelocity (0, -300)
			end -- fecha o if event.other

			elseif event.other.id == "moeda" then 
				display.remove (event.other)
				hud.somar ()
			end -- fecha o if self.y
		end -- fecha o if event.phase
	end -- fecha a function onCollision

	player.collision = onCollision
	player:addEventListener ("collision")

	return player
end -- fecha player.novo

return Player 
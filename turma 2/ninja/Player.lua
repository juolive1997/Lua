TecladoClasse = require ("Teclado")

local Player = {}


function Player.novo (x, y, hud)

	-- Inclui a imagem da sprite dentro do script ("pasta/imagem.formato", {largura, altura, numero total de quadros })
	local playerSprite = graphics.newImageSheet ("player-sprite-sheet.png", {width=90, height=95, numFrames= 12})

	-- inclui as informações sobre a animação da sprite.
	local playerAnimacao = 
	{
		-- nome, frame inicio, continua por mais x frames, tempo, repetições
		{name= "parado", start=1, count= 3, time=300, loopCont=0}, 
		{name="correndo", start=5, count= 9, time= 1000, loopCont=0}
	}


	local player = display.newSprite (playerSprite, playerAnimacao)
	player.x = x
	player.y = y

	player.id = "Player"
	player.direcao = "parado"

	player:setSequence ("parado")
	player:play ()

	player.numeroPulo = 0 

-- adicionando física ao player no formato box. 
		-- (variavel, "tipo de física",{fricção, box= {x, y, largura, altura, angulo }})
	physics.addBody(player, "dynamic", {friction=2, box= {x=0, y=0, halfWidth=30, halfHeight=40, angle=0}})
	player.isFixedRotation = true 

-- inicia os controles e envia o player para o script do Teclado.lua 
	TecladoClasse.novo (player)

	local function verificar_colisao( self, event )
		if event.phase == "began" then
		
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
				hud.somar()
			end

		end
	end
	player.collision = verificar_colisao
	player:addEventListener( "collision" )


	return player

end -- fecha a function 

return Player 















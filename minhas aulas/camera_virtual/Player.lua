local TecladoClasse = require( "Teclado" )

local Player = {}


function Player.novo( x, y )
	
	-- Coloca na memória uma spriteSheet( sequencia de imagens ) com as suas informações ( imagem      , { largura   , altura     , n° total quadros })                                          
	local playerSpriteSheet = graphics.newImageSheet( "player-sprite-sheet.png", { width = 90, height = 95, numFrames = 12 } )

	-- coloca na memoria informações sobre a animação
	local playerAnimation = 
			{
			   -- nome           , inicio , termina, tempo duração, contagem de loops
				{ name = "parado", start = 1, count = 3, time = 300, loopCount = 0 },
				{ name = "correndo", start = 5, count = 9, time = 500, loopCount = 0 }

			}

	-- Coloca o player na tela com as configurações referentes as variáveis de spriteSheet acima
	local player = display.newSprite( playerSpriteSheet, playerAnimation )
	player.x = x
	player.y = y

	player.id = "player"
	player.direcao = "parado"

	-- altera a sequencia para uma sequencia disponivel na variável playerAnimation
	player:setSequence( "parado" )
	player:play()

	player.numero_pulo = 0

	-- Coloca um corpo no player e usa parametros de box( caixa ) para aumentar e diminuir o corpo fisico do personagem
	-- Utilize a setDrawMode("hybrid") para ver o corpo na forma de box(caixa) 

	physics.addBody( player, "dynamic", { friction = 2, box = { x = 0, y = 0, halfWidth = 30, halfHeight = 40, angle = 0 } } )
	player.isFixedRotation = true


	-- Inicia os controles e envia o player para o script do Teclado.lua
	TecladoClasse.novo( player )
	


	-- O player dentro da colisão é o objeto self
	-- self significa prório( eu mesmo )
	local function verificar_colisao( self, event )
		
		if event.phase == "began" then
			-- verifico quem é o outro objeto envolvido na colisão através do event.other
			-- other significa outro 
			if event.other.id == "chao" then
				self.numero_pulo = 0

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
	player.collision = verificar_colisao
	player:addEventListener( "collision" )


	return player
end -- Fim da função Player.novo()

return Player
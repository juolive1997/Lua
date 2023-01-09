-- variável que guarda a referencia do objeto dono do script
local player = {}
print( "Invoquei o script player.lua")


-- Cria um novo player na tela
function player.novo( grupo_jogo, grupo_HUD )
	print( "Novo player na tela" )

	local player = display.newImageRect( "imagens/nave-heroi-02.png", 100, 100 )
	player.x = math.random(0, 320)
	player.y = 280
	player.direcao = "parado" -- Parado
	player.id = "player"
	physics.addBody( player, "kinematic", { radius = 44 } )
	grupo_jogo:insert( player )

	local botao_direita = display.newImageRect( "imagens/button.png", 54, 54 )
	botao_direita.x = 260
	botao_direita.y = 427
	grupo_HUD:insert( botao_direita )

	-- Função que realiza a soma na posição X do player
	local function trocar_para_direita( event )
		
		if ( event.phase == "began" ) then
			player.direcao = "direita"
			botao_direita.xScale = 0.8
			botao_direita.yScale = 0.8

		elseif ( event.phase == "ended" ) then
			player.direcao = "parado"
			botao_direita.xScale = 1
			botao_direita.yScale = 1

		end
	end
	botao_direita:addEventListener( "touch", trocar_para_direita )



	local botao_esquerda = display.newImageRect( "imagens/button.png", 54, 54 )
	botao_esquerda.x = 60
	botao_esquerda.y = 427
	botao_esquerda.rotation = 180
	grupo_HUD:insert( botao_esquerda )

	-- Função que realiza a soma na posição X do player
	local function trocar_para_esquerda( event )
		
		if not ( player.x == nil ) then -- verifica se o player ainda está visivel na tela
			if ( event.phase == "began" ) then
				player.direcao = "esquerda"
				botao_esquerda.xScale = 0.8
				botao_esquerda.yScale = 0.8

			elseif ( event.phase == "ended" ) then
				player.direcao = "parado"
				botao_esquerda.xScale = 1
				botao_esquerda.yScale = 1

			end
		end
	end
	botao_esquerda:addEventListener( "touch", trocar_para_esquerda )


	-- Cria uma forma retangular 			   x ,  y , L , A
	local botao_tiro = display.newRect( 160, 430, 24, 24 )
	grupo_HUD:insert( botao_tiro )

	local function atirar()
		print( "tentando atirar" )
		if not ( player.x == nil ) then
			local projetil_player = display.newCircle( player.x, player.y-30, 3 )
			physics.addBody( projetil_player, "dynamic", { isSensor = true } )
			projetil_player:setLinearVelocity( 0, -200 )
			projetil_player.id = "projetil_player"
			grupo_jogo:insert( projetil_player )
		end
	end
	botao_tiro:addEventListener( "touch", atirar )


	-- Fica sendo chamado 60 vezes a cada segundo
	local function mover_player()
		-- Fica o 60 vezez por segundo verificando se o player deve
		-- ir para a direita
		if not ( player.x == nil ) then

			if ( player.direcao == "direita" ) then
				player.x = player.x + 1
				print( player.direcao )

			elseif ( player.direcao == "esquerda" ) then
				player.x = player.x - 1
				print( player.direcao )

			end

		end
	end
	Runtime:addEventListener( "enterFrame", mover_player )


	return player
end



-- Retorna o objeto para a tela que o chamou
return player
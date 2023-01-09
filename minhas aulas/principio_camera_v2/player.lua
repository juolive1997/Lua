-- variável que guarda a referencia do objeto dono do script
local player = {}


-- Cria um novo player na tela
function player.novo( grupo_meio, grupo_jogo, grupo_HUD )

	local player = display.newImageRect("imagens/player.png", 532*0.3, 469*0.3)
	player.x = 110
	player.y = 160


	player.direcao = "parado" -- Parado
	player.id = "player"
	

	local botao_direita = display.newImageRect( "imagens/button.png", 54, 54 )
	botao_direita.x = 410
	botao_direita.y = 280
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
	botao_esquerda.y = 280
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


	-- Fica sendo chamado 60 vezes a cada segundo
	local function mover_player()
		-- Fica o 60 vezez por segundo verificando se o player deve
		-- ir para a direita
		if not ( player.x == nil ) then

			if ( player.direcao == "direita" ) then
				print( player.direcao )
				grupo_jogo.x = grupo_jogo.x - 1

			elseif ( player.direcao == "esquerda" ) then
				print( player.direcao )
				grupo_jogo.x = grupo_jogo.x + 1.5

				grupo_meio.x = grupo_meio.x + 1


			end

		end
	end
	Runtime:addEventListener( "enterFrame", mover_player )


	return player
end



-- Retorna o objeto para a tela que o chamou
return player
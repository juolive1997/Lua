-- Solicita a fisica dentro do script atual
local physics = require( "physics" )

-- Iniciar a fisica no script
physics.start()

-- Altera a gravidade X e gravidade Y
physics.setGravity( 0, 0 )

physics.setDrawMode( "normal" ) -- hybrid/debug/normal



local bg = display.newImageRect(  "imagens/bg-3.jpg", 1366*0.65, 768*0.65 )
bg.x = 160
bg.y = 240

local player = display.newImageRect( "imagens/nave-heroi-02.png", 100, 100 )
	player.x = 160
	player.y = 380
	player.direcao = "parado" -- Parado
	player.id = "player"
	physics.addBody( player, "kinematic", {radius = 40} )

local botao_direita = display.newImageRect( "imagens/button.png", 54, 54 )
	botao_direita.x = 260
	botao_direita.y = 427

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

-- Função que realiza a soma na posição X do player
local function trocar_para_esquerda( event )

	if not (player.x == nil ) then -- verifica se o player está visivel na tela
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
local botao_tiro = display.newRect( 160, 430, 30, 30 )

local function atirar()
	if not (player.x == nil ) then 
	print( "Atirando!" )
	local projetil_player = display.newCircle( player.x, player.y-30, 3 )
	physics.addBody( projetil_player, "dynamic", { isSensor = true } )
	projetil_player:setLinearVelocity( 0, -200 )
	projetil_player.id = "projetil_player"
	local pontos = 0
	local pontos_texto = display.newText( {text="Pontos: " .. pontos, x=40, y=20, font=nil, fontSize=16} )
		--soma os pontos
		pontos = pontos +1
		pontos_texto.text = "Pontos: " .. pontos 
	end
end
botao_tiro:addEventListener( "touch", atirar )

local direcao_todos_inimigos = "direita"

local function criar_inimigo (x_inicial, y_inicial)

	local inimigo = display.newImageRect( "imagens/nave-inimiga.png", 640*0.10, 366*0.10 )
	inimigo.x = x_inicial
	inimigo.y = y_inicial
	-- Variável de controle de direção
	
	inimigo.id = "inimigo"
	physics.addBody( inimigo, "kinematic", { isSensor = true} )

	local function inimigo_atirar()
		print("inimigo atirou!")
		local projetil= display.newCircle( inimigo.x, inimigo.y+20, 4 )
		--  Altera a cor do objeto de forma geométrica
		-- 				   R,   G, B,  A
		projetil:setFillColor( 0, 0.4, 1, 0.6 )
		physics.addBody( projetil,  "dynamic", { isSensor= true} )
		projetil:setLinearVelocity( 0 , 200)
		projetil.id = "projetil_inimigo"
	end
	inimigo.timer_atirar = timer.performWithDelay( 2000, inimigo_atirar, 0 )

	local function movimentar_inimigo()

		if not ( inimigo.x == nil ) then -- Verifica se o inimigo está vivo 

		--  Se ( Direção do inimigo for igual a o valor estipulado ) then
			if ( direcao_todos_inimigos == "direita" ) then
				inimigo.x = inimigo.x +1

				-- Verifica se chegou no limite a direita
				if ( inimigo.x >= 320 ) then
					direcao_todos_inimigos = "esquerda"
				end

			elseif ( direcao_todos_inimigos == "esquerda" ) then
				inimigo.x = inimigo.x -1

				-- Verifica se chegou no limite a esquerda
				if ( inimigo.x <= 0 ) then
					direcao_todos_inimigos = "direita"
				end
						
			end -- Fim do block if

		else -- qualquer outra coisa faço isso 
			print( "Inimigo morreu!" )
			
			-- Removeu o enterFrame que movimenta o inimigo
			Runtime:removeEventListener ( "enterFrame", movimentar_inimigo )
			
		end

	end
	-- A função associada a um evento de enterFrame
	-- é chamada 60 vezes a cada 1 segundo
	-- Runtime ( tempo de execução ), representa o meu aplicativo todo
	Runtime:addEventListener( "enterFrame", movimentar_inimigo )
end


-- Ultimo grupo inimigos
criar_inimigo (60, 60)
criar_inimigo (130, 60)
criar_inimigo (200, 60)
criar_inimigo (270, 60)

-- inimigos do meio
criar_inimigo (95, 120)
criar_inimigo (165, 120)
criar_inimigo (235, 120)

--inimigo da frente
criar_inimigo (165,180)

-- Fica sendo chamado 60 vezes a cada segundo
local function mover_player()
	-- Fica o 60 vezez por segundo verificando se o player deve
	-- ir para a direita
	if not (player.x == nil ) then 
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


-- Função que verifica a colisão entre objetos 
local function verificar_colisao ( event )
	if ( event.phase == "began" ) then 
	local vidas_texto = display.newText( {text="Vidas: " .. vidas, x=160, y=20, font=nil, fontSize=16} )
		vidas = vidas - 1
		print( "Algo colidiu!" )
		print( "objeto 1: " .. event.object1.id )
		print( "objeto 2: " .. event.object2.id )
		if ( event.object1.id == "projetil_inimigo" and event.object2.id == "player" ) then
	local vidas = 3
		vidas_texto.text = "Vidas: " .. vidas
			-- Remove o objeto de numero 2 e 1 envolvido na colisão
			display.remove ( event.object1 )
			
		if (vidas <= 0 ) then 	
			display.remove ( event.object2 )
			Runtime:removeEventListener ("enterFrame", mover_player)
			botao_direita:removeEventListener( "touch", trocar_para_direita )
			botao_esquerda:removeEventListener( "touch", trocar_para_esquerda )
			botao_tiro:removeEventListener( "touch", atirar )
		end


		elseif ( event.object1.id == "inimigo" and event.object2.id == "projetil_player" ) then 
			display.remove( event.object1 )
			display.remove( event.object2 )

			-- cancela o timer do tiro do inimigo que foi morto nesta colisão.
			timer.cancel( event.object1.timer_atirar)


	elseif( event.phase == "ended" ) then 
		print(" Algo Se desgrudou! ")
	end
end
-- Adiciona um eventListener de colisão global
-- Consegue detectar colisão em todos os objtos com fisica
Runtime:addEventListener( "collision", verificar_colisao )
end
local diff_x = 0
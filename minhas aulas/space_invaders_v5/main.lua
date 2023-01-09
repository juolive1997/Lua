-- Invoco o script player.lua e guardo dentro de uma variável
local player_script = require( "player" )

local inimigo_script = require( "inimigo" )


-- Solicita a fisica dentro do script atual
local physics = require( "physics" )

-- Iniciar a fisica no script
physics.start()

-- Altera a gravidade X e gravidade Y
physics.setGravity( 0, 0 )

physics.setDrawMode( "normal" ) -- hybrid/debug/normal


local grupo_fundo = display.newGroup()

local grupo_jogo = display.newGroup()

local grupo_HUD = display.newGroup()


local bg = display.newImageRect(  "imagens/bg-3.jpg", 1366*0.65, 768*0.65 )
bg.x = 160
bg.y = 240
grupo_fundo:insert( bg )


local player = player_script.novo( grupo_jogo, grupo_HUD )

inimigo_script.novo( grupo_jogo )

local pontos = 0
local pontos_texto = display.newText( { text="Pontos: " .. pontos, x=40, y=20, font=nil, fontSize=16 } )
grupo_HUD:insert( pontos_texto )


local vidas = 3
local vidas_texto = display.newText( { text="Vidas: " .. vidas, x=160, y=20, font=nil, fontSize=16 } )
grupo_HUD:insert( vidas_texto )


-- Função que verifica a colisão entre os objetos
local function verificar_colisao( event )
	if ( event.phase == "began" ) then
		print( "Algo colidiu!" )
		print( "objeto 1: " .. event.object1.id )
		print( "objeto 2: " .. event.object2.id )

		if ( event.object1.id == "projetil_inimigo" and event.object2.id == "player" ) then
			-- Remove o objeto de numero 2 e 1 envolvidos na colisão
			display.remove( event.object1 )

			vidas = vidas - 1
			vidas_texto.text = "Vidas: " .. vidas

			-- Verifica se a vida é menor ou igual a 0
			if ( vidas <= 0 ) then
				display.remove( event.object2 )
				Runtime:removeEventListener( "enterFrame", mover_player )
				botao_direita:removeEventListener( "touch", trocar_para_direita )
				botao_esquerda:removeEventListener( "touch", trocar_para_esquerda )
				botao_tiro:removeEventListener( "touch", atirar )
			end


		elseif ( event.object1.id == "inimigo" and event.object2.id == "projetil_player" ) then
			display.remove( event.object1 )
			display.remove( event.object2 )

			-- cancela o timer do tiro do inimigo que foi morto nesta colisão
			timer.cancel( event.object1.timer_atirar )
		
			-- soma os pontos
			pontos = pontos +100
		
			-- Altera o texto texto e concatena com a variável pontos
			pontos_texto.text = "Pontos: " .. pontos


		end

	elseif( event.phase == "ended" ) then
		print( "Algo se desgrudou!" )

	end

end
-- Adiciona um eventListener de colisão global
-- Consegue detectar colisão em todos os objetos com fisica
Runtime:addEventListener( "collision", verificar_colisao )
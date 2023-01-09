local bg = display.newImageRect( "images/bg.jpg", 626*1.3, 354*1.4 )
bg.x = 320/2
bg.y = 480/2

local player = display.newImageRect( "images/nave_heroi_02.png", 100, 100 )
player.x = 160
player.y = 380

local inimigo = display.newImageRect( "images/nave_inimiga.png", 640*0.25, 366*0.25 )
inimigo.x = 160
inimigo.y = 60
-- Variável de controle de direção
inimigo.direcao = "direita"

local function movimentar_inimigo( ... )


	-- Se o (X do inimigo for igual ao valor estipulado) then
	if (inimigo.direcao == "direita") then
		inimigo.x = inimigo.x +1 

			-- verifica se chegou no limite a direita
			if (inimigo.x == 320) then 
			inimigo.direcao = "esquerda"
			end

	elseif (inimigo.direcao == "esquerda") then
		inimigo.x = inimigo.x -1
		
			if (inimigo.x == 0) then
			inimigo.direcao = "direita"
			end

	end -- fim do block if

	--print( inimigo.x )
end
-- A função associada a um evento de enterFrame é chamada 60 vezes a cada segundo
-- Runtime (tempo de execução) representa meu aplicativo todo.
Runtime:addEventListener( "enterFrame", movimentar_inimigo )


-- Fases de toque:
-- began - A fase é executada ao tocar na tela.
-- moved - A fase é executada ao arrastar o dedo na tela.
-- ended - A fase é executada ao tirar o dedo da tela. 
local function trocar_direcao_player ( event )
	--print( "Movendo Player" )
	if (event.phase == "began") then 
		print( "iniciou o toque na tela" )
		print( "Event X", event.x  )
		if (event.x > 160 ) then 
			player.direcao = "direita"
			print( player.direcao )
		end

	if (event.x < 160) then 
		player.direcao = "esquerda"
		print( player.direcao )
	end 

elseif (event.phase == "ended") then 
	player.direcao = "parado"
	print ("Finalizou toque na tela")
	print("event: ", event.x)
end

	end 

Runtime:addEventListener( "touch", trocar_direcao_player )
-- Fica sendo chamado 60 vezes a cada segundo.
local function mover_player ()
	--fica 60 vezes por segundo verificando se o player deve ir para a direita

	if (player.direcao == "direita" ) then 
		player.x = player.x +1
	end 

	if (player.direcao == "esquerda") then
		player.x = player.x -1
	end
end

Runtime:addEventListener ("enterFrame", mover_player )
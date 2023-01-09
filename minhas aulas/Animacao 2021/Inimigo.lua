local Inimigo = {}


function Inimigo.novo( x, y )
	
	-- Coloca na memória uma spriteSheet( sequencia de imgagens ) com as suas informações ( imagem      , { largura   , altura     , n° total quadros })                                          
	local inimigoSpriteSheet = graphics.newImageSheet( "inimigo-sprite-sheet_dark.png", { width = 90, height = 95, numFrames = 12 } )

	-- coloca na memoria informações sobre a animação
	local inimigoAnimation = 
			{
			   -- nome           , inicio , termina, tempo duranção, contagem de loops
				{ name = "parado", start = 1, count = 3, time = 300, loopCount = 0 },
				{ name = "correndo", start = 5, count = 9, time = 1000, loopCount = 0 }

			}

	-- Coloca o player na tela com as configurações referentes as variáveis de spriteSheet acima
	local inimigo = display.newSprite( inimigoSpriteSheet, inimigoAnimation )
	inimigo.x = x
	inimigo.y = y

	inimigo.id = "inimigo"
	inimigo.direcao = "esquerda"

	inimigo:setSequence( "correndo" )
	inimigo:play()

	inimigo.numero_pulo = 0

	-- Coloca um corpo no inimigo e usa parametros de box( caixa ) para aumentar e diminuir o corpo fisico do personagem
	-- Utilize a setDrawMode("hybrid") para ver o corpo na forma de box(caixa) 

	physics.addBody( inimigo, "dynamic", { friction = 2, box = { x = 0, y = 0, halfWidth = 30, halfHeight = 40, angle = 0 } } )
	inimigo.isFixedRotation = true	


	local function verificar_direcao ()
		

		if (inimigo.direcao == "esquerda" ) then 
			inimigo.x = inimigo.x -2
			if (inimigo.x <= 0 ) then 
				inimigo.direcao = "direita"
				inimigo.xScale = 1
			end

		elseif (inimigo.direcao == "direita") then
			inimigo.x = inimigo.x +2

			if (inimigo.x >= 480 ) then 
				inimigo.direcao = "esquerda"
				inimigo.xScale = -1

			end
		end

	end 

	Runtime:addEventListener( "enterFrame", verificar_direcao )


	return inimigo
end -- Fim da função Inimigo.novo()

return Inimigo
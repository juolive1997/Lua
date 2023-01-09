local Inimigo = {}
--local playerScript = require ("Player")

function  Inimigo.novo ( mainGroup )

	--physics.start ()
	local inimigoDirecao = "direita"

	local function criarInimigo (xInicial, yInicial)
		--
	local inimigoSprite = graphics.newImageSheet ("imagens/inimigo2.png", {width= 192, height= 256, numFrames=45 })

	local inimigoAnimacao = { 
		{name="parado", start=1, count=1, time=1000, loopCont=0 }, 
		{name="andando", start=37, count=8, time=2000, loopCont=0},
		{name="atirar", start=33, coont=1, time=3000, loopCont=0}
	}

	local inimigo =display.newSprite (inimigoSprite, inimigoAnimacao)
	inimigo.x = xInicial -- define que a localização x do inimigo será colocada quando a função for chamada para o inimigo aparecer na tela.
	inimigo.y = yInicial -- define que a localização y do inimigo será colocada quando a função for chamada para o inimigo aparecer na tela.

	inimigo:setSequence ("andando")
	inimigo:play ()
	
	inimigo.id= "Inimigo"
	physics.addBody (inimigo, "kinematic") -- objeto não sofre alterações sobre gravidade.

	local function inimigoAtirar ()
			-- cia um circulo para servir como projetil para o inimigo.
			local projetilInimigo = display.newCircle (inimigo.x + 20, inimigo.y, 20)
			physics.addBody (projetilInimigo, "kinematic", {isSensor = true})
			transition.to (projetilInimigo, {x = 0, time = 1500,
				onComplete = function () display.remove (projetilInimigo) end})
			projetilInimigo.id = "projetilInimigo"
			inimigo:setSequence ("atirar")
			inimigo:play ()
		
		end -- fecha a função inimigoAtirar

	inimigo.timerAtirar = timer.performWithDelay (math.random (3000, 8000), inimigoAtirar, 0)

		local function movimentarInimigo ()
			-- verifica se o inimigo está vivo. 
			if not (inimigo.x == nil ) then

				if (inimigoDirecao == "direita") then 
					inimigo.x = inimigo.x +1 
					inimigo:setSequence ("andando")
					inimigo:play ()
					inimigo.xScale= 1


					if (inimigo.x >= 1280 ) then 
						inimigoDirecao = "esquerda"

					end -- fecha o if inimigo.x

				elseif (inimigoDirecao == "esquerda") then 
					inimigo.x = inimigo.x -1
					inimigo:setSequence ("andando")
					inimigo:play ()
					inimigo.xScale= -1

					if (inimigo.x <= 0 ) then
						inimigoDirecao = "direita"
					end -- fecha o if inimigo.x 

				end -- fecha o if inimigoDirecao
			else 

				Runtime:removeEventListener ("enterFrame", movimentarInimigo)
			end -- fecha o if not 
		end -- fecha a função movimentarInimigo

Runtime:addEventListener ("enterFrame", movimentarInimigo)

	end -- fecha a função criarInimigo

	criarInimigo (1280, 570)

end -- fecha Inimigo.novo

return Inimigo 
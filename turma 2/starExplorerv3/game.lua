	
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local physics = require ("physics")
physics.start ()
physics.setGravity (0,0)

-- definições da sprite 
local spriteOpcoes = 
{

	frames= 
	{ 
		{ -- 1) asteroide 1
			x= 0,
			y= 0,
			width= 102,
			height= 85
		},
		{ -- 2) asteroide 2
			x= 0,
			y= 85,
			width= 90,
			height= 83
		},
		{-- 3) asteroide 3
			x= 0,
			y= 168,
			width= 100,
			height= 97
		},
		{ -- 4) Nave
			x= 0,
			y= 265,
			width= 98,
			height= 79 
		}, 
		{ -- 5) laser
			x= 98, 
			y= 265, 
			width= 14,
			height= 40
		},	
	},
}

-- incluindo a imagem da sprite no script.
local sprite = graphics.newImageSheet ("imagens/player.png", spriteOpcoes)

local vidas = 3
local pontos = 0 
local morto = false 

local asteroidesTable = {}

local nave
local gameLoopTimer
local vidasText
local pontosText 

local backGroup -- usado para o plano de fundo.
local mainGroup  -- usado para os objetos que terão interação dentro do jogo.
local uiGroup -- usado para placar, vidas etc.

-- variaveis para sons 
local somExplosao 
local somTiro 
local musicaFundo 

local function atualizaText ()
	vidasText.text = "Vidas: " .. vidas
	pontosText.text = "Pontos: " .. pontos
end 

local function criarAsteroide ()
	local novoAsteroide = display.newImageRect (mainGroup, sprite, 1, 102, 85)
-- inclui o novo asteroide dentro da tabela asteroidesTable.
	table.insert (asteroidesTable, novoAsteroide)
	physics.addBody (novoAsteroide, "dynamic", {radius=40, bounce=0.8 } )
	novoAsteroide.myName = "Asteróide"

	local localizacao = math.random (3)

-- se localização for igual a 1 então
	if (localizacao == 1) then 
		novoAsteroide.x = -60 
		novoAsteroide.y = math.random (500)
-- determina a velocidade que o asteroide irá se mover vertical e horizontalmente. 
		novoAsteroide:setLinearVelocity (math.random (40,120), math.random (20,60)) 

	elseif (localizacao == 2) then
		novoAsteroide.x = math.random (display.contentWidth)
		novoAsteroide.y = -60
		novoAsteroide:setLinearVelocity (math.random (-40, 40), math.random (40,120))

	elseif (localizacao == 3) then
		novoAsteroide.x = display.contentWidth + 60
		novoAsteroide.y = math.random (500)
		novoAsteroide:setLinearVelocity	(math.random (-120, -40), math.random (20,60))
	end
-- cria efeito de rotação sob o próprio eixo no asteroide.
	novoAsteroide:applyTorque (math.random (-6, 6))
end 

local function atirar ()

	audio.play (somTiro)
	local novoLaser = display.newImageRect (mainGroup, sprite, 5, 14, 40)
	physics.addBody (novoLaser, "dynamic", {isSensor=true})
-- configura o laser como uma "bala", fazendo com que a detecção de colisão fique mais sensível e não passe batido.	
	novoLaser.isBullet = true 
	novoLaser.myName = "Laser"

	novoLaser.x = nave.x
	novoLaser.y = nave.y 
-- joga o laser para trás dentro do seu grupo.
	novoLaser:toBack ()
-- faz com que o laser transite até a linha -40 na horizontal em meio segundo. 
	--            (objeto (variável), {localização final, tempo em que deve realizar a transição}).
	transition.to (novoLaser, {y=-40, time= 500, 
-- Faz com que ao completar a transição, o sistema remova os lasers para não pesar o jogo.
		onComplete = function () display.remove (novoLaser) end 
		
	} )

end

local function moverNave (event)
-- define que a nave irá passar pela fase de evento. 
	local nave = event.target 
-- define a variável phase para identificar a fase de toque.
	local phase = event.phase 

-- Quando a fase de toque for igual a began então.
	if ("began" == phase ) then 
		-- todas as mudanças de direção enquanto o mouse estiver apertado estão focados na nave.
		display.currentStage:setFocus (nave)
		-- salva a posição inicial da nave. 
		nave.touchOffsetX = event.x - nave.x 

	elseif ("moved" == phase ) then
		-- mover a nave na horizontal
		nave.x = event.x - nave.touchOffsetX

	elseif ("ended" == phase or "cancelled" == phase ) then
		-- retira o foco de toque da nave.
		display.currentStage:setFocus (nil )
	end

	return true -- pára o evento de toque para não propagar nos outros objetos.

end

local function gameLoop ()
	
	criarAsteroide ()

-- define o indice da tabela. O # é utilizado para contar quantos asteróides há na tabela.
	for i = #asteroidesTable, 1, -1 do 
		local thisAsteroid = asteroidesTable[i]
-- define os parâmetros de fora da tela nos eixos x e y. 
		if (thisAsteroid.x < -100 or 
			thisAsteroid.x > display.contentWidth + 100 or
			thisAsteroid.y < -100 or
			thisAsteroid.y > display.contentHeight + 100 )
		then 
			-- remove o asteroide da tela.
			display.remove (thisAsteroid)
			-- remove o asteroide da tabela e do indice.
			table.remove (asteroidesTable, i)
		end -- fecha o if
	end -- fecha o for
end -- fecha a function 

 local function restauraNave ()

-- remove a nave como um corpo ativo no jogo.
 	nave.isBodyActive = false 
 	nave.x = display.contentCenterX
 	nave.y = display.contentHeight - 100

 	transition.to (nave, {alpha=1, time=4000, 
 		onComplete = function ()
 		nave.isBodyActive= true 
 		morto = false
 		end 
 	})
end 

local function  endGame ()
	composer.gotoScene ("menu", {time=800, effect="crossFade" } )
end

local function recordes ()
	composer.setVariable ("finalScore", pontos )
	composer.gotoScene ("recordes", {time=800, effect="crossFade"})
end	

local function onCollision (event)
	if (event.phase == "began" ) then 

		local obj1 = event.object1
		local obj2 = event.object2

		if (( obj1.myName == "Laser" and obj2.myName == "Asteróide" ) or 
			(obj1.myName == "Asteróide" and obj2.myName == "Laser"))
		then 
			display.remove (obj1)
			display.remove (obj2)

			-- reproduz o audio quando detectar a colisão. 
			audio.play (somExplosao)

				for i = #asteroidesTable, 1, -1 do
					if (asteroidesTable[i] == obj1 or asteroidesTable[i] == obj2) then 
						table.remove (asteroidesTable, i )
						break -- para o loop assim que remover o asteroide colidido. 
					end -- fecha o if 
				end -- fecha o for

				pontos = pontos + 100 
				pontosText.text = "Pontos: " .. pontos 

		elseif (( obj1.myName == "Nave" and obj2.myName == "Asteróide" ) or 
				(obj1.myName == "Asteróide" and obj2.myName == "Nave"))
		then 
			if (morto == false ) then 
				morto = true 

				audio.play (somExplosao)

				vidas = vidas - 1
				vidasText.text = "Vidas: " .. vidas 

				if (vidas == 0 ) then 
					display.remove (nave) 
					local gameOver = display.newImageRect (uiGroup, "imagens/gameOver.png", 360, 360)
					gameOver.x = display.contentCenterX
					gameOver.y = display.contentCenterY
					
					local restart = display.newImageRect (uiGroup, "imagens/restart.png", 474/3, 526/3)
					restart.x = display.contentCenterX
					restart.y = 750
					restart:addEventListener ("tap", endGame)

					local botaoRecordes = display.newText (uiGroup, "Recordes", display.contentCenterX, 910, Arial, 80)
						botaoRecordes:setFillColor (0.75, 0.78, 1 )
						botaoRecordes:addEventListener ("tap", recordes )
				else 
					nave.alpha = 0 
					timer.performWithDelay (1000, restauraNave)
				end -- fecha o if vidas
			end -- fecha o if morto
		end -- fecha o segundo if
	end -- fecha o primeiro if
end -- fecha a function 



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	physics.pause ()

	backGroup = display.newGroup () -- usado para o plano de fundo.
	sceneGroup:insert (backGroup)
	mainGroup = display.newGroup () -- usado para os objetos que terão interação dentro do jogo.
	sceneGroup:insert (mainGroup)
	uiGroup = display.newGroup () -- usado para placar, vidas etc.
	sceneGroup:insert (uiGroup)

	local bg = display.newImageRect (backGroup, "imagens/bg.png", 800, 1400)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	nave = display.newImageRect (mainGroup, sprite, 4, 98, 79)
	nave.x = display.contentCenterX
	nave.y = display.contentHeight - 100 
	-- isSensor: determina que a nave é um sensor, detectará as colisões porém não irá recochetear nos objetos.
	physics.addBody (nave, {radius=30, isSensor=true}) 
	nave.myName = "Nave"

	-- adicionando vidas e pontos na tela.
	vidasText = display.newText (uiGroup, "Vidas: " .. vidas, 200, 80, Arial, 36)
	pontosText = display.newText (uiGroup, "Pontos: " .. pontos, 400, 80, Arial, 36)

	nave:addEventListener ("tap", atirar)
	nave:addEventListener ("touch", moverNave)
	
	-- incluindo o arquivo de som no script (pasta/arquivo.formato )
	somExplosao = audio.loadSound ("audio/explosion.wav")
	somTiro = audio.loadSound ("audio/fire.wav")

	-- incluindo a música de fundo no script. (pasta/arquivo.formato )
	musicaFundo = audio.loadStream ("audio/80s-Space-Game_Looping.wav")
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		physics.start ()
		Runtime:addEventListener ("collision", onCollision)
		gameLoopTimer = timer.performWithDelay (500, gameLoop, 0)
		-- inicia a música de fundo. 
		audio.play (musicaFundo, {channel= 1, loops= -1 })
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		timer.cancel (gameLoopTimer)


	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		Runtime:removeEventListener ("collision", onCollision)
		physics.pause ()
	-- para o audio da música de fundo quando encerra a cena. 
		audio.stop ( 1 )
		composer.removeScene ( "game" )
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose (somExplosao)
	audio.dispose (somTiro)
	audio.dispose (musicaFundo)
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene

local physics = require ("physics") -- chama a física para o projeto.
physics.start () -- inicia a física.
physics.setGravity (0, 0) -- define a gravidade da física.

-- irá gerar objetos pré determinados num intervalo aleatório.
math.randomseed (os.time () )

-- SPRITE: Imagem que contém um conjunto de várias imagens dentro dela.
local sheetOptions = {frames = 
						{ 
							-- discriminação do local na imagem original 
							{-- 1- asteroide 1 
							x=0, y=0, width = 102, height= 85},
							{-- 2- asteroide 2
							x=0, y=85, width=90, height=83},
							{ -- 3- asteroide 3
							x=0, y=168, width=100, height=97},
							{ -- 4- nave
							x=0, y=265, width=98, height=79},
							{ -- 5- laser
							x=98, y=265, width= 14, height= 40},
						}
					}
local player = graphics.newImageSheet("imagens/player.png",sheetOptions)

local vidas = 3
local pontos = 0
local morto = false 

local asteroidsTable = {}

local nave 
local gameLoopTimer
local vidasText 
local pontosText

-- criando grupos de imagens
local backGroup = display.newGroup () -- grupo do background
local mainGroup = display.newGroup () -- grupo da nave, asteroides, laser etc
local uiGroup = display.newGroup () -- grupo relacionado aos scores.


local bg = display.newImageRect (backGroup, "imagens/bg.png", 800, 1400)
bg.x = display.contentCenterX
bg.y = display.contentCenterY
                      -- (grupo, variavel da sprite, localização pela ordem, dimensões.)
nave = display.newImageRect (mainGroup, player, 4, 98, 79 )
nave.x = display.contentCenterX
nave.y = display.contentHeight - 100
physics.addBody (nave, {radius= 30, isSensor=true})
nave.myName = "Nave"

-- adicionar as vidas na tela
vidasText = display.newText (uiGroup, "Vidas: " .. vidas, 200, 80, Arial, 40)
pontosText = display.newText (uiGroup, "Pontos: " .. pontos, 450, 80, Arial, 40 )

-- remove a barra de status do telefone, deixando o app em tela cheia. 
display.setStatusBar (display.HiddenStatusBar)

local function atualizeText ()
	vidasText.text = "Vidas: " .. vidas
	pontosText.text = "Pontos: " .. pontos
end

local function criar_asteroide ()
	local novoAsteroide = display.newImageRect (mainGroup, player, 1, 102, 85)
	table.insert (asteroidsTable, novoAsteroide )
	physics.addBody (novoAsteroide, "dynamic", {radius=40, bounce= 0.8} )
	novoAsteroide.myName = "Asteróide"

	local localizacao = math.random (3)
	-- dois == equivalem a comparação
		if (localizacao == 1) then 
			novoAsteroide.x = 60
			novoAsteroide.y = math.random (500)
			novoAsteroide:setLinearVelocity (math.random (40, 120), math.random (20,60))
		

		elseif (localizacao == 2) then 
			novoAsteroide.x = 200
			novoAsteroide.y = -60
			novoAsteroide:setLinearVelocity( math.random (-40, 40), math.random(40,120))
	
		elseif (localizacao == 3) then
			novoAsteroide.x = display.contentWidth + 60
			novoAsteroide.y = math.random (500)
			novoAsteroide:setLinearVelocity (math.random (-120, -40), math.random (20,60))
		end

		-- rotação no próprio eixo. 
novoAsteroide:applyTorque (math.random (-6, 6))
end

local function atirar ()
	local novoLaser = display.newImageRect (mainGroup, player, 5, 14, 40)
	physics.addBody (novoLaser, "dynamic", {isSensor=true})
	-- determina o laser como arma, fazendo com que as detecções de colisão sejam mais rápidas.
	novoLaser.isBullet = true 
	novoLaser.myName = "Laser"
	novoLaser.x = nave.x 
	novoLaser.y = nave.y 
	-- empurra o objeto pra trás dentro do seu grupo.
	novoLaser:toBack()

-- define que o objeto irá até a posição determinada no tempo x. 
	transition.to (novoLaser, {y=-40, time= 500, 
		onComplete = function() display.remove (novoLaser) end
		}) 
end

nave:addEventListener( "tap", atirar )

local function moverNave (event) -- evento de toque
local nave = event.target 
local phase = event.phase 

	if ("began" == phase ) then 
		-- define o foco do toque na nave.
		display.currentStage:setFocus( nave )
		-- Armazena a posição de deslocamento inicial
		nave.touchOffsetX = event.x - nave.x

	elseif ("moved" == phase ) then 
		nave.x = event.x - nave.touchOffsetX

	elseif ("ended" == phase or "cancelled" == phase ) then 
	display.currentStage:setFocus( nil )
	end
	return true
end

nave:addEventListener ("touch", moverNave )

-- fases de toque: 
-- began - toque inicial da tela.
-- moved - toque se move no objeto.
-- ended - toque retirado da tela.
-- canceled - sistema cancelou o rastreamento do toque.

local function gameLoop ()
-- cria novo asteroide.
criar_asteroide() 
	for i = #asteroidsTable, 1, -1 do
		local thisAsteroid = asteroidsTable [i] 

		if ( thisAsteroid.x < -100 or 
		  thisAsteroid.x > display.contentWidth + 100 or 
		   thisAsteroid.x < -100 or 
		   thisAsteroid.x > display.contentHeight + 100 )
		then 
			display.remove (thisAsteroid)
			table.remove( asteroidsTable, i )
		 end
	end 
end
--                                     (tempo, função, quantidade de repetições, 0 = infinito)
gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )	


local function restauraNave ()
	nave.isBodyActive = false
	nave.x = display.contentCenterX
	nave.y = display.contentHeight - 100

	transition.to (nave, {alpha=1, time=4000, 
		onComplete = function ()
			nave.isBodyActive = true
			morto = false 
	end
 })
end 

local function onCollision (event)
	if (event.phase == "began" ) then 

		local obj1 = event.object1
		local obj2 = event.object2

	-- identifica os objetos que irão colidir
	if (( obj1.myName == "Laser" and obj2.myName == "Asteróide") or 
	 	( obj1.myName == "Asteróide" and obj2.myName == "Laser") )
		then
		display.remove ( obj1 )
		display.remove ( obj2 )


		for i = #asteroidsTable, 1, -1 do
			if ( asteroidsTable [i] == obj1 or asteroidsTable[i] == obj2 ) then 
				table.remove( asteroidsTable, i )
				-- função executa apenas com os envolvidos. 
				break 
				end
			end
			-- soma ao score 
			pontos = pontos + 100
			pontosText.text = "Pontos: " .. pontos 

		elseif ((obj1.myName == "Nave" and obj2.myName == "Asteróide" ) or 
		 		( obj1.myName == "Asteróide" and obj2.myName == "Nave")	)
		then 
			if (morto == false ) then 
				morto = true 

			vidas = vidas -1
			vidasText.text = "Vidas: " .. vidas 

				if (vidas == 0 ) then 
					display.remove( nave )
				else 
					nave.alpha = 0 
					timer.performWithDelay( 1000, restauraNave )
				end
			end
		end
	end 
end 

Runtime:addEventListener( "collision", onCollision )


-- local: váriavel, nomeia uma variável, coloca os elementos no jogo. 
-- physics (física no projeto) 
-- = (atribui valor a algo) 
-- Ao utilizar a física, primeiro passo é chamar a física no projeto. 
local physics = require ("physics")

-- start (): iniciam a física no projeto. 
physics.start ()


--             valor
-- setGravity (número gravidade x , número gravidade y), 
--determina qual gravidade da física no projeto.
physics.setGravity (0 , 0)


-- math.random sorteio de números entre intervalo pré determinado
-- para execução de função escolhida.
math.randomseed (os.time () )



-- adicionar imagem ao projeto: (pasta/arquivo.formato, dimensões)
local bg = display.newImageRect ("imagens/bg.png", 800, 1400)
-- x = localização da imagem horizontalmente. Aumenta conforme vai 
-- para a direita. Para centralizar a imagem usamos o comando
-- contentCenter.
bg.x = display.contentCenterX 

-- y = localização do objeto verticalmente. Aumenta conforme vai para
-- baixo. 
bg.y = display.contentCenterY 


-- 	SPRITE: Uma imagem que contém um compilado de imagens, geralmente
-- utilizada em animações. 
-- para incluir a sprite é necessário antes de chamar o arquivo definir
-- o tamanho e localização de cada objeto que a compõe.
--                     frames=cada um dos objetos que contém na sprite.
local sheetOptions = { frames = 
	-- discriminar: ordem (para organização pessoal), localização x e y
	-- da imagem na SPRITE, e dimensões de cada objeto.
						{
							{-- 1- Asteróide 1
							x=0, y=0, width = 102, height= 85},
--                      {linha, coluna, largura, altura}
							{-- 2- Asteróide 2
							x=0, y=85, width=90, height=83},
							{-- 3- Asteróide 3
							x=0, y=168, width=100, height=97},
							{-- 4- Nave
							x=0, y=265, width=98, height=79},
							{-- 5- Laser
							x=98, y=265, width=14, height=40},
						}
							}
-- Após determinar as dimensões e localização de cada sprite, chamamos
-- a imagem da sprite para o arquivo.
local player = graphics.newImageSheet( "imagens/player.png", sheetOptions)

-- CRIAR VÁRIAVEIS QUE SERÃO UTILIZADAS NOS PRÓXIMOS COMANDOS.


-- variáveis da função de colisão e scores.
local vidas = 3 
local pontos = 0 
local morto = false 

-- Tabela é criada quando temos mais de um objeto que cumprirá a mesma função dentro do projeto, ou seja, agrupar.
local asteroidsTable = {}


local nave 
local gameLoopTimer
local vidasText
local pontosText


-- CRIANDO GRUPOS: 
local backGroup = display.newGroup ( ) -- Grupo do background, para imagens que irão ficar ao fundo, e não terão 
-- interação direta com o jogo. 
local mainGroup = display.newGroup ( ) -- Grupo que interage entre si, onde geralmente ficam as funções.
local uiGroup = display.newGroup () -- Grupo relacionado aos textos e pontuações no jogo, que mudam de acordo com as
-- interações do grupo main.

--                              (grupo que a imagem pertence, "pasta/imagem", dimensões)
local bg = display.newImageRect (backGroup, "imagens/bg.png", 800, 1400)
bg.x = display.contentCenterX
bg.y = display.contentCenterY


-- incluindo imagem que está na sprite: 


--                    (grupo, variavel que chamou sprite, localização da imagem na ordem, dimensões)
nave = display.newImageRect( mainGroup, player, 4, 98, 79 )
nave.x = display.contentCenterX
nave.y = display.contentHeight - 100
-- adicionando física a imagem (transforma imagem em objeto)
--              (variavel, {circunferência da física, não rebate quando se choca em outros objetos})
physics.addBody( nave, {radius=30, isSensor=true} )
-- adicionar nome ao objeto, para utilizar nas funções de colisão.
nave.myName = "Nave"


-- ADICIONAR SCORE E VIDAS NA TELA:
-- variavel texto = display.newText (grupo, "texto que irá aparecer na tela" concatena com a variável que possui
-- valor, localização x na tela, localização y na tela, fonte, tamanho da fonte)
vidasText = display.newText ( uiGroup, "Vidas: " .. vidas, 200, 80, Arial, 20 )

pontosText = display.newText ( uiGroup, "Pontos: " .. pontos, 80, 80, Arial, 20 )
-- alterar cor do texto (vermelho, verde, azul e alfa(transparência) )
pontosText:setFillColor( 0, 0, 0, 1) 

-- REMOVER BARRA DE STATUS (NOTIFICAÇÕES DO CELULAR)
display.setStatusBar (display.HiddenStatusBar) 

-- ATUALIZAR PONTOS DE ACORDO COM A FUNÇÃO.
-- variável de função 
local function atualizeText ()
-- função de texto da variável de texto 
		vidasText.text = "Vidas: " .. vidas
		pontosText.text = "Pontos: " .. pontos
end -- end finaliza a função, todos os comandos valem para o que está dentro dela.

local function criarAsteroide ()
	local novoAsteroide = display.newImageRect (mainGroup, player, 1, 102, 85)
-- incluir asteroide dentro da tabela criada anteriormente
	table.insert( asteroidsTable, novoAsteroide)
-- adicionar física ao asteróide 
	physics.addBody (novoAsteroide, "dynamic", {radius=40, bounce= 0.8} )
	novoAsteroide.myName = "Asteróide"


-- localização definida por sorteio math.random, contendo 3 opções. 
		local localizacao = math.random (3)

-- utilização do if. 
-- 		If: se (variavél for igual a 1) então
			if (localizacao == 1) then 
				novoAsteroide.x = 60
			-- novo asteroide surgirá entre as linhas 1 e 500 
				novoAsteroide.y = math.random (500)
		-- velocidade em que o asteróide irá se movimentar na tela.
-- 			variavel:velocidadeLinear (sorteio (velocidade horizontal(x) ente ), sorteio (velocidade vertical y entre))
				novoAsteroide:setLinearVelocity (math.random (40, 120), math.random (20,60))

-- entretanto se (variavel for igual a 2) então 
			elseif (localizacao == 2) then 
				novoAsteroide.x = 200
				novoAsteroide.y = -60
				novoAsteroide:setLinearVelocity( math.random (-40, 40), math.random(40,120))

			elseif (localizacao == 3) then
			novoAsteroide.x = display.contentWidth + 60
			novoAsteroide.y = math.random (500)
			novoAsteroide:setLinearVelocity (math.random (-120, -40), math.random (20,60))
			
			end -- fechando a função if. 

-- para o asteróide girar em torno dele mesmo. 
-- variável:aplicaTorque (sorteio (entre número, número))
novoAsteroide:applyTorque( math.random (6, -6) )
end -- fecha a função criar asteróide. 

local function atirar ()
	local novoLaser = display.newImageRect (mainGroup, player, 5, 14, 40)
	physics.addBody (novoLaser, "dynamic", {isSensor=true})
-- determina o objeto como arma, fazendo com que as colisões sejam lidas com mais rapidez para que
-- não se perca nenhuma. 
		novoLaser.isBullet = true 
		novoLaser.myName = "Laser"
		novoLaser.x = nave.x 
		novoLaser.y = nave.y
-- empurra o objeto pra trás dentro do seu grupo: 
		novoLaser:toBack ()

-- Definição de transição: 
-- define que o objeto irá percorrer em determinado tempo, o trajeto até a localização estipulada.
		transition.to (novoLaser, {y=-40, time= 500, -- milisegundos, um segundo = 1000
-- Quando o objeto completar a transição, deverá ser removido do display. 
		onComplete = function() display.remove (novoLaser) end
		}) 
end -- fecha a função atirar. 

-- adicionar evento para sempre que clicar executar a função.
-- variável:addEventListener ("tap = clique", função a ser executada)
nave:addEventListener( "tap", atirar )


-- EVENTO DE TOQUE ( BEGAN, MOVED, ENDED, CANCELED), são utilizados para definir o que deve ser executado em cada
-- fase de toque.

-- began - toque inicial da tela.
-- moved - toque se move no objeto.
-- ended - toque retirado da tela.
-- canceled - sistema cancelou o rastreamento do toque.

local function moverNave (event) -- função do evento de toque
local nave = event.target -- objeto que foi/será tocado para iniciar a função. 
local phase = event.phase -- define a fase em que o evento se encontra.

-- se ("evento de toque" for igual a fase) então 
	if ("began" == phase ) then 
-- o foco do toque se torna o objeto mencionado. 
		display.currentStage:setFocus( nave )
-- armazena a posição de deslocamento inical do objeto.
		nave.touchOffsetX = event.x - nave.x

-- entretanto se ("evento de toque" for igual a fase) então 
	elseif ("moved" == phase ) then 
		nave.x = event.x - nave.touchOffsetX -- se move de acordo com o touch na linha x

	elseif ("ended" == phase or "cancelled" == phase ) then 
-- retira o foco de toque do objeto 
	display.currentStage:setFocus( nil )
	end -- fecha a função if 
	return true -- parar o evento de toque. 
end 
	----------------------------------- OU -----------------------------------------------
-- USO DE BOTÕES PARA MOVIMENTAÇÃO DO PLAYER 

-- Cria-se a função para a direção desejada: 
local function andar_direita ()
	-- cada vez que a função for executada a variavel soma N na horizontal.  
	frango.x = frango.x +2
end -- fecha a função andar_direita.

-- Adiciona o botão no jogo
local direita = display.newImageRect( "imagens/button.png", 1280/20, 1279/20 )
-- localização do botão 
direita.x = 280
direita.y = 430
-- adiciona a execução da função ao tocar a imagem.
direita:addEventListener ("touch", andar_direita)

-- EVENT LISTENER: 
-- Tap: Relacionado ao clique, utilizado geralmente para tiros ou pulos.
-- Touch: Relacionado ao toque, quando segura e arrasta segue executando. 



local function gameLoop () 
	criarAsteroide () -- cria novo asteróide dentro da função.
-- Remove asteróides que saíram da tela
-- (i= determina que o loop vá do início ao fim dentro da tabela. Indice)
	for i = #asteroidsTable, 1, -1 do
-- identifica que todos os itens ta tabela são thisAsteroid. 
		local thisAsteroid = asteroidsTable [i] 

-- determina que sempre que um asteróide aparecer fora da tela e/ou no espaço em que o player se encontra será removido
-- do display e da tabela.
		if ( thisAsteroid.x < -100 or -- ou
		  thisAsteroid.x > display.contentWidth + 100 or 
		   thisAsteroid.x < -100 or 
		   thisAsteroid.x > display.contentHeight + 100 )
		then 
			display.remove (thisAsteroid)
			table.remove( asteroidsTable, i )
		 end -- fecha a função if
	end -- fecha a função for
end -- fecha a função gameLoop

-- Determinando Timer de repetição da função. 
-- 									(tempo, função, quantidade de repetições (0=infinito) )
gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0)


-- Função para restaurar nave. 
local function restauraNave ()
	-- identificando se a nave está na tela. 
		nave.isBodyActive = false
	-- reinclui a nave na tela na localização inicial. 
		nave.x = display.contentCenterX
		nave.y = display.contentHeight - 100

-- transição para a nave voltar para a tela, 
--                     variavel, volta a opacidade normal no período de N milisegundos. 
		transition.to (nave, {alpha=1, time=4000, 
				onComplete = function ()
					nave.isBodyActive = true
-- identifica que a nave está de volta na tela.
					morto = false 
							end -- fecha a função onComplete
 })
end -- fecha a função restauraNave. 



-- Função de colisão: 
local function onCollision (event)
	if (event.phase == "began" ) then -- determinando a fase inicial do evento com began
-- cria a variavel dos objetos que irão colidir.
		local obj1 = event.object1
		local obj2 = event.object2
-- identifica (nomeia) os objetos que irão colidir
	if (( obj1.myName == "Laser" and obj2.myName == "Asteróide") or 
	 	( obj1.myName == "Asteróide" and obj2.myName == "Laser") )
		then 
-- remove os objetos da tela ao se colidirem.
		display.remove( obj1 )
		display.remove( obj2 )

-- executa a tabela para dentro da função, e define que o asteróide sera removido também da tabela.
for i = #asteroidsTable, 1, -1 do
			if ( asteroidsTable [i] == obj1 or asteroidsTable[i] == obj2 ) then 
				table.remove( asteroidsTable, i )
-- função executada apenas com os envolvidos. 
			break 
			end -- fecha a função if 
		end -- fecha a função for.

-- adicionando soma ao score.
pontos = pontos + 100
pontosText.text = "Pontos: " .. pontos

			elseif ((obj1.myName == "Nave" and obj2.myName == "Asteróide" ) or 
		 			( obj1.myName == "Asteróide" and obj2.myName == "Nave")	)
			then
-- identifica se a nave já saiu da tela
if (morto == false ) then 
-- se ainda não, define como morto.
				morto = true 	

-- Faz a subtração da variável vidas e concatena para a função vidasText ser atualizada.
			vidas = vidas -1
			vidasText.text = "Vidas: " .. vidas 

-- determina que quando vidas for igual a 0 remove-se a nave, e ela não torna a aparecer.
if (vidas == 0 ) then 
					display.remove( nave )
				else 
					nave.alpha = 0 
-- após um segundo, executa a função restauraNave
					timer.performWithDelay( 1000, restauraNave )
				end -- fecha if vidas
			end -- fecha função elseif
		end -- fecha função for
	end -- fecha função if event 
end -- fecha função de colisão 

-- inicia o evento de colisão com EventListener.
Runtime:addEventListener( "collision", onCollision )

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

CENAS: 

-- Devem ser inseridos os códigos abaixo na ABA MAIN. 

local composer = require ("composer") -- Solicita a biblioteca composer no lua. 

-- variavel.vá para a cena ("nome da cena")
composer.gotoScene( "menu" )

-- ABA MENU (Cria o menu do jogo, tela inicial quando o usuário for iniciar o game)


local composer = require( "composer" ) -- Chama novamente a biblioteca composer na cena.

local scene = composer.newScene() -- cria nova cena. 

local function gotoGame () -- função para iniciar o jogo.
	composer.gotoScene ("game") -- determina que com essa variável iremos para a cena game.lua.
end -- fecha a função gotoGame

local function gotoRecordes () -- função para exibir os recordes do jogo.
	composer.gotoScene ("recordes") -- determina que com essa variável iremos para a cena recordes.lua
end -- fecha a função gotoRecordes. 

-- EVENTO DE FUNÇÕES: 
-- criar a função de evento: 
function scene:create( event )
	local sceneGroup = self.view 
-- O código aqui é executado quando a cena é criada pela primeira vez, mas ainda não apareceu na tela

-- incluir plano de fundo.
local bg = display.newImageRect (sceneGroup, "imagens/bg.png", 800,1400)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

-- incluir logo do jogo:
local titulo = display.newImageRect (sceneGroup, "imagens/title.png", 500, 80)
	titulo.x = display.contentCenterX
	titulo.y = 200

-- incluir botão play: 
	local botaoPlay = display.newText (sceneGroup, "Play", display.contentCenterX, 700, Arial, 44 )
	botaoPlay:setFillColor (0.82, 0.86, 1) -- altera cor do texto.

-- incluir botão recordes: 
	local botaoRecordes = display.newText (sceneGroup, "Recordes", display.contentCenterX, 810, Arial, 44 )
	botaoRecordes:setFillColor (0.75, 0.78, 1)

-- adicionar eventListener para habilitar a função clique nos dois botões.
	botaoPlay:addEventListener ("tap", gotoGame)
	botaoRecordes:addEventListener ("tap", gotoRecordes)

end -- fecha a função scene:create. 
 

-- criar a função de evento de cena show.
function scene:show( event )

	local sceneGroup = self.view -- grupo de cena = visualização. 
	local phase = event.phase -- fase de evento 

-- quando a fase de evento for igual a will então
	if ( phase == "will") then 
-- O código aqui é executado quando a cena ainda está fora da tela (mas está prestes a entrar na tela)

-- entretanto, quando a fase de evento for igual a did então 
	elseif (phase == "did") then 
-- O código aqui é executado quando a cena está inteiramente na tela

	end -- fecha o if 
end -- fecha a função scene:show.


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

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

----------------------------------------------------------------------------
-- CENA GAME: 


local composer = require( "composer" )

local scene = composer.newScene()

-- ADICIONAR FÍSICA NO JOGO

local physics = require ("physics") -- chama a física para o projeto.
physics.start () -- inicia a física.
physics.setGravity (0, 0) -- define a gravidade da física.

-- ADICIONAR SPRITE: 

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

-- CRIAR VARIAVEIS PADRÕES
local vidas = 3
local pontos = 0
local morto = false 

local asteroidsTable = {}

local nave 
local gameLoopTimer
local vidasText 
local pontosText

local backGroup 
local mainGroup 
local uiGroup


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

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	physics.pause () -- pausa temporária na física

	backGroup = display.newGroup ()
	sceneGroup:insert (backGroup)

	mainGroup = display.newGroup ()
	sceneGroup:insert (mainGroup)

	uiGroup = display.newGroup ()
	sceneGroup:insert (uiGroup)

	local bg = display.newImageRect (backGroup, "imagens/bg.png", 800, 1400)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	nave = display.newImageRect (mainGroup, player, 4, 98, 79 )
	nave.x = display.contentCenterX
	nave.y = display.contentHeight - 100
	physics.addBody (nave, {radius= 30, isSensor=true})
	nave.myName = "Nave"

-- adicionar as vidas na tela
	vidasText = display.newText (uiGroup, "Vidas: " .. vidas, 200, 80, Arial, 40)
	pontosText = display.newText (uiGroup, "Pontos: " .. pontos, 450, 80, Arial, 40 )

nave:addEventListener( "tap", atirar )
nave:addEventListener ("touch", moverNave )

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Quando a cena está pronta para ser exibida antes da transição.

	elseif ( phase == "did" ) then
		-- Quando a cena já está sendo exibida após a transição.

		physics.start( )
		Runtime:addEventListener( "collision", onCollision )
		gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

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











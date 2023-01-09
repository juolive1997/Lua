
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local json = require ("json") -- chama a biblioteca json no script.

local pontosTable = {}

local filePath = system.pathForFile ("pontos.json", system.DocumentsDirectory ) -- criando o arquivo pontos.json e gerando um caminho.  

local musicaFundo

local function carregaPontos ()

	local pasta = io.open (filePath, "r") -- abre o arquivo pontos.json para somente leitura, apenas para confirmar que o arquivo existe.
	
	if pasta then 
		local contents = pasta:read ("*a") -- despeja o conteúdo do arquivo na variável contents.
		io.close (pasta)
		pontosTable = json.decode (contents ) -- decodifica os dados que estão em .json para a tabela.
	end -- fecha o if 

	if (pontosTable == nil or #pontosTable == 0 ) then
		pontosTable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0} -- pontuações iniciais nos recordes. 
	end -- fecha o if 

end -- fecha a function 


local function salvaPontos ()
	for i = #pontosTable, 11, -1 do -- define que somente 10 pontuações serão salvas na tabela.
		table.remove (pontosTable, i )
	end -- fecha a variável for 

	local pasta = io.open (filePath, "w") -- abre o arquivo para alterações. 

	if pasta then 
		pasta:write (json.encode (pontosTable ) ) -- codifica os dados da tabela no formato .json 
		io.close (pasta)
	end -- fecha o if 
end -- fecha a function 

local function gotoMenu ()
	composer.gotoScene ("menu", {time=800, effect="crossFade"} )
end 

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	carregaPontos ()

	-- Insira a pontuação salva do último jogo na mesa e redefina-a
	table.insert (pontosTable, composer.getVariable ("finalScore") ) 

	composer.setVariable ("finalScore", 0 )

	-- Função para ordenar os valores da tabela do menor para o maior.
	local function compare ( a, b )
		return a > b 
	end
	table.sort (pontosTable, compare ) -- classifica a ordem definida em compare para a table.

	salvaPontos ()


	local bg = display.newImageRect (sceneGroup, "imagens/bg.png", 800, 1400)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	local cabecalho = display.newText ( sceneGroup, "Recordes", display.contentCenterX, 100, Arial, 120 )

	-- Criando um loop de 1 a 10 para exibir as pontuações
	for i = 1, 10 do
		if (pontosTable[i] ) then 
		-- Faz com que as pontuações fiquem espaçadas uniformemente de acordo com o tamanho.
			local yPos = 150 + (i * 56)

			local rankNum = display.newText (sceneGroup, i .. ")", display.contentCenterX-50, yPos, Arial, 44)
			rankNum:setFillColor (0.8)
			-- alinha a direita
			rankNum.anchorX = 1

			local finalPontos = display.newText (sceneGroup, pontosTable[i], display.contentCenterX-30, yPos, Arial, 44)
			-- alinha a esquerda
			finalPontos.anchorX = 0 

		end -- fecha o if
	end -- fecha o for 

		local botaoMenu = display.newText (sceneGroup, "Menu", display.contentCenterX, 810, Arial, 50)
		botaoMenu:setFillColor (0.75, 0.78, 1)
		botaoMenu:addEventListener ("tap", gotoMenu)

		musicaFundo = audio.loadStream ("audio/Midnight-Crawlers_Looping.wav")
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		audio.play (musicaFundo, {channel= 1, loops= -1 })

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
		audio.stop ( 1 )
		composer.removeScene ("recordes")

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
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

local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local playerScript = require ("Player")
local tecladoScript = require ("teclado")
local inimigoScript = require ("Inimigo")

local physics = require ("physics")
physics.start ()
physics.setGravity (0, 6)
physics.setDrawMode ("hybrid") 

local musicaFundo

local pontos = 0
local vidas = 3
local pontosInimigo = 0
local morto = false 
local player 
local inimigo
local moeda 

local backGroup
local mainGroup
local uiGroup 

------------- sons:
local somTiro
local somPonto
local somInimigo 
local somZumbi -- canal 



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
		physics.pause ()

		backGroup = display.newGroup ()
		sceneGroup:insert (backGroup)

		mainGroup = display.newGroup ()
		sceneGroup:insert (mainGroup)

		uiGroup = display.newGroup ()
		sceneGroup:insert (uiGroup)

		local bg = display.newImageRect (backGroup, "imagens/bg2.jpg", 960*2, 404*2)
		bg.x = display.contentCenterX
		bg.y = display.contentCenterY

		local chao = display.newImageRect (mainGroup, "imagens/chao.png", 4503/3, 613/3)
		chao.x = display.contentCenterX
		chao.y = display.contentHeight - 30
		physics.addBody (chao, "static", {friction=5, box={x=0, y=0, halfWidth=chao.width/2, halfHeight=chao.height/5}})
		chao.id = "chao"


		local player =  playerScript.novo()
		mainGroup:insert (player)

		local inimigo = inimigoScript.novo ()

		musicaFundo = audio.loadStream ("audio/game.mp3")
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
		audio.play (musicaFundo, {channel=1, loops=-1})
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
		audio.stop (1)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose  (musicaFundo)
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



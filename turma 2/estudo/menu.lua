
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotoGame ()
	composer.gotoScene ("game", {time=500, effect="crossFade"})
end 

local function gotoRecordes ()
	composer.gotoScene ("recordes", {time=500, effect="crossFade"})
end 

local musicaFundo

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
		local bg = display.newImageRect (sceneGroup, "imagens/bg.jpg", 1024*2, 527*2)
		bg.x = display.contentCenterX
		bg.y = display.contentCenterY

		local botaoPlay = display.newImageRect (sceneGroup, "imagens/start.png", 500/1.5, 320/1.5)
		botaoPlay.x = display.contentCenterX
		botaoPlay.y = 300
		botaoPlay:addEventListener ("tap", gotoGame)

		local botaoRecordes = display.newImageRect (sceneGroup, "imagens/recordes.png", 710/1.6, 290/1.6)
		botaoRecordes.x = display.contentCenterX
		botaoRecordes.y = 500
		botaoRecordes:addEventListener ("tap", gotoRecordes)

		musicaFundo = audio.loadStream ("audio/menu.mp3")

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		audio.play (musicaFundo, {channel=1, loops=-1 })
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

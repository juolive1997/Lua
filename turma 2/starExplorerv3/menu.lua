
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame ()
	composer.gotoScene ("game", {time=800, effect= "crossFade"})

end

local function gotoRecordes ()
	composer.gotoScene ("recordes", {time=800, effect="crossFade"})
end 

local musicaFundo 


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Ocorre quando a cena é criada pela primeira vez mas ainda não apareceu na tela.

		local bg = display.newImageRect (sceneGroup, "imagens/bg.png", 800, 1400)
		bg.x = display.contentCenterX
		bg.y = display.contentCenterY

		local titulo = display.newImageRect (sceneGroup, "imagens/title.png", 500, 80)
		titulo.x = display.contentCenterX
		titulo.y = 200 

		local botaoPlay = display.newText (sceneGroup, "Play", display.contentCenterX, 700, Arial, 60)
		botaoPlay:setFillColor (0.82, 0.86, 1 )

		local botaoRecordes = display.newText (sceneGroup, "Recordes", display.contentCenterX, 810, Arial, 60)
		botaoRecordes:setFillColor (0.75, 0.78, 1 )

		musicaFundo = audio.loadStream ("audio/Escape_Looping.wav")

		botaoPlay:addEventListener ("tap", gotoGame)
		botaoRecordes:addEventListener ("tap", gotoRecordes)
end


-- show()
		-- ocorre imediatamente antes e após a cena aparecer na tela.
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
-- O código aqui é executado quando a cena ainda está fora da tela (mas está prestes a entrar na tela)

	elseif ( phase == "did" ) then
		-- O código aqui é executado quando a cena está inteiramente na tela
		audio.play (musicaFundo, {channel= 1, loops= -1 })

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
-- O código aqui é executado quando a cena está na tela (mas está prestes a sair da tela)
	elseif ( phase == "did" ) then
-- O código aqui é executado imediatamente após a cena sair totalmente da tela
	audio.stop ( 1 )

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
-- O código aqui é executado antes da remoção da visão da cena
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

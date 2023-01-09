

------------------------------
-- CONFIGURE STAGE
------------------------------

----------------------
-- COMEÇAR O CÓDIGO DE AMOSTRA
----------------------

-- Set up physics engine
local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 9.8 )
physics.setDrawMode( "normal" )

-- Declara variáveis ​​iniciais
local letterboxWidth = (display.actualContentWidth-display.contentWidth)/2
local letterboxHeight = (display.actualContentHeight-display.contentHeight)/2

-- Adicione três objetos físicos como bordas para o líquido simulado, localizado fora da tela visível
local leftSide = display.newRect( -54-letterboxWidth, display.contentHeight-180, 600, 70 )
physics.addBody( leftSide, "static" )
leftSide.rotation = 86

local centerPiece = display.newRect( display.contentCenterX, display.contentHeight+60+letterboxHeight, 440, 120 )
physics.addBody( centerPiece, "static" )

local rightSide = display.newRect( display.contentWidth+54+letterboxWidth, display.contentHeight-180, 600, 70 )
physics.addBody( rightSide, "static" )
rightSide.rotation = -86

-- Crie um fundo de rolagem sem fim, usando a imagem de fundo de "Congelar!"

local background1 = display.newImageRect( "background.png", 320, 480 )
background1.x = 160
background1.y = 240
background1.xScale = 1.202
background1.yScale = 1.200
transition.to( background1, { time=12000, x=-224, iterations=0 } )

local background2 = display.newImageRect( "background.png", 320, 480 )
background2.x = 544
background2.y = 240
background2.xScale = 1.202
background2.yScale = 1.200
transition.to( background2, { time=12000, x=160, iterations=0 } )

-- Crie nosso olho (o herói de "Freeze!")
local hero = display.newImageRect( "hero.png", 64, 64 )
hero.x = 160
hero.y = -400
physics.addBody( hero, { density=0.7, friction=0.3, bounce=0.2, radius=30 } )

-- Torne o herói arrastável por meio de um manipulador de toque e junta de toque de física
local function dragBody( event )
	local body = event.target
	local phase = event.phase

	if ( "began" == phase ) then
		display.getCurrentStage():setFocus( body, event.id )
		body.isFocus = true
		body.tempJoint = physics.newJoint( "touch", body, event.x, event.y )
		body.isFixedRotation = true
	elseif ( body.isFocus ) then
		if ( "moved" == phase ) then
			body.tempJoint:setTarget( event.x, event.y )
		elseif ( "ended" == phase or "cancelled" == phase ) then
			display.getCurrentStage():setFocus( body, nil )
			body.isFocus = false
			event.target:setLinearVelocity( 0,0 )
			event.target.angularVelocity = 0
			body.tempJoint:removeSelf()
			--body.isFixedRotation = false  -- Use esta linha se o olho deve girar na água

		end
	end
	return true
end
hero:addEventListener( "touch", dragBody )

-- Crie o sistema de partículas LiquidFun para a água
local particleSystem = physics.newParticleSystem{
	filename = "liquidParticle.png",
	radius = 3,
	imageRadius = 5,
	gravityScale = 1.0,
	strictContactCheck = true
}

-- Crie um "bloco" de água (grupo LiquidFun)
particleSystem:createGroup(
    {
        flags = { "tensile" },
       x = 160,
        y = 0,
        color = { 0.1, 0.1, 0.1, 1 },
        halfWidth = 128,
        halfHeight = 256
    }
)

-- Inicializa o instantâneo para tela cheia
local snapshot = display.newSnapshot( 320+letterboxWidth+letterboxWidth, 480+letterboxHeight+letterboxHeight )
local snapshotGroup = snapshot.group
snapshot.x = 160
snapshot.y = 240
snapshot.canvasMode = "discard"
snapshot.alpha = 0.3

-- Aplique um filtro "sobel" para retratar a superfície visível da água
snapshot.fill.effect = "filter.sobel"

-- Insira o sistema de partículas no instantâneo
snapshotGroup:insert( particleSystem )
snapshotGroup.x = -160
snapshotGroup.y = -240

-- Traga o herói para a frente de seu grupo de exibição
hero:toFront()

-- Atualiza (invalida) o snapshot de cada frame
local function onEnterFrame( event )
	snapshot:invalidate()
end
Runtime:addEventListener( "enterFrame", onEnterFrame )

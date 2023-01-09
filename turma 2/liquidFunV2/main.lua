-- iniciar a física no script
local physics = require ("physics")
physics.start ()
physics.setGravity (0, 9.8)
physics.setDrawMode ("normal")

-- declarar variáveis iniciais.
local letterboxWidth = (display.actualContentWidth-display.contentWidth)/2
local letterboxHeight = (display.actualContentHeight-display.contentHeight)/2

-- adicionar 3 objetos físicos na tela como bordas para que o liquido se mantenha visível na tela.
local paredeEsquerda = display.newRect (-54-letterboxWidth, display.contentHeight-180, 600, 70)
physics.addBody (paredeEsquerda, "static")
paredeEsquerda.rotation = 86

local chao = display.newRect (display.contentCenterX, display.contentHeight+60+letterboxHeight, 440, 120)
physics.addBody (chao, "static")

local paredeDireita = display.newRect (display.contentWidth+54+letterboxWidth,display.contentHeight-180, 600, 70)
physics.addBody (paredeDireita, "static")
paredeDireita.rotation = -86 


-- adicionando fundo sem fim. 

local bg1 = display.newImageRect ("background.png", 320, 480)
bg1.x = 160
bg1.y = 240
bg1.xScale = 1.202
bg1.yScale =1.200
transition.to (bg1, {time=12000, x=-224, iterations=0 })

local bg2 = display.newImageRect ("background.png", 320,480)
bg2.x = 544
bg2.y = 240
bg2.xScale = 1.202
bg2.yScale = 1.200
transition.to  (bg2, {time=12000, x=160, iterations=0})

local hero = display.newImageRect ("hero.png", 64, 64)
hero.x = 160
hero.y = -400
-- density= parametro usado para definir se o objeto é mais leve ou pesado que a agua (bóia ou afunda), parâmetro da água 1.0
physics.addBody (hero, {density=0.7, friction=0.3, bounce=0.2, radius=30})


local function moverHero ( event )
	local body = event.target 
	local phase = event.phase


	if ("began" == phase )then
		display.getCurrentStage():setFocus(body, event.id)
		body.isFocus = true 
		body.tempJoint = physics.newJoint ("touch", body, event.x, event.y)
		body.isFixedRotation = true 

	elseif (body.isFocus ) then
		if ("moved" == phase ) then
			body.tempJoint:setTarget (event.x, event.y )

		elseif ("ended" == phase or "cancelled" == phase ) then 
			display.getCurrentStage():setFocus (body, nil )
			body.isFocus = false 
			event.target:setLinearVelocity (0,0)
			event.target.angularVelocity = 0
			body.tempJoint:removeSelf()
			body.isFixedRotation = false -- deve ser comentado caso não queira que o herói gire dentro da água.

		end 
	end 
	return true 
end 

hero:addEventListener ("touch", moverHero)


-- criar um sistema de partículas para a agua.

local particleSystem = physics.newParticleSystem {
	filename= "liquidParticle.png",
	radius=3,
	imageRadius= 5,
	gravityScale= 1.0,
	--Verificação de contato rigorosa
	strictContactCheck= true 

}

-- criando um "bloco" de água.

particleSystem:createGroup (

	{ flags={"tensile"}, -- tração
		x=160,
		y= 0,
		color= {0.1, 0.1, 0.1, 1}, 
		halfWidth= 128,
		halfHeight=256 })

--Inicializa a tela cheia instantanea.
 
local snapshot = display.newSnapshot (320+letterboxWidth+letterboxWidth, 480+letterboxHeight+letterboxHeight)
local snapshotGroup = snapshot.group 
snapshot.x= 160
snapshot.y = 240
snapshot.canvasMode = "discard"
snapshot.alpha = 0.3

-- aplica um filtro sobel para retratar a superfície vísivel da água.
snapshot.fill.effect = "filter.sobel"


-- inclui o sistema de partículas dentro do snapshot

snapshotGroup:insert (particleSystem)
snapshotGroup.x = -160
snapshotGroup.y = -240

-- trás o herói pra frente dentro do grupo de exibição.
hero:toFront ()

-- invalida o snapshot de cada frame.
local function onEnterFrame (event )
	snapshot:invalidate()
end 

Runtime:addEventListener ("enterFrame", onEnterFrame )
-- Solicitar a física dentro do script.
local physics = require ("physics")
--  Iniciar a física no script 
physics.start ()
-- Alterar a gravidade X e Y do script.
physics.setGravity (0, 10 )
-- Define o estilo de física ("normal/hybrid/debug")
-- Normal: somente os objetos, hybrid: objetos com o radius, debug: somente o radius.
physics.setDrawMode ("normal")

-- Remove a barra de notificações da tela.
display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/bg.jpg", 1920/2, 1080/2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local function criarItens ()
	local largura = 563*0.1
	local pocao = display.newImageRect ("imagens/potion.png", largura, 561*0.1 )

	pocao.x = math.random (50, 320)
	pocao.y = 40
-- adicionar física no objeto (variável, "tipo de física(dynamic, static)", {radius= área de colisão}) 
	physics.addBody (pocao, "dynamic", {radius=largura/2})
end
timer.performWithDelay (500, criarItens, 0)

local chao = display.newRect (240, 500, 480, 20)
physics.addBody (chao, "static")

local paredeEsquerda = display.newRect (0, 200, 20, 580)
physics.addBody (paredeEsquerda, "static")

-- incluir retangulo para fechar uma "caixa"
local paredeDireita = display.newRect (320, 200, 20, 580)
physics.addBody (paredeDireita, "static")






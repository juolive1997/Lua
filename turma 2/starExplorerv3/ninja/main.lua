local playerScript = require ("Player")

-- solicita a biblioteca de câmera virtual. 
local perspective = require ("perspective")

-- cria a camera 
local camera = perspective.createView ()

-- prepara e organiza os layers da camera.
camera:prependLayer()

local physics = require ("physics")
physics.start ()
physics.setGravity (0, 15)
physics.setDrawMode ("hybrid") 

display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/bg.jpg", 509*3, 339*3)
bg.x = display.contentCenterX
bg.y = display.contentCenterY
-- planos de 1 ao 8 onde quanto maior o número mais profundo está o plano na perspectiva do usuário. 
camera:add (bg, 8)

local sol = display.newImageRect ("imagens/sun.png", 256, 256)
sol.x = 1000
sol.y = 150
camera:add (sol, 7)


for i= 0,4 do
	local nuvens = display.newImageRect ("imagens/cloud.png", 2360/5, 984/5)
	nuvens.x = math.random (-100, 800)*i 
	nuvens.y = math.random (-60, 200)
	nuvens.alpha = 0.8 
	camera:add (nuvens, 7)
end 


for i= 0,3 do
	local nuvens = display.newImageRect ("imagens/cloud.png", 2360/5, 984/5)
	nuvens.x = math.random (-100, 600) *i 
	nuvens.y = math.random (-60, 300)
	nuvens.alpha = 0.8 
	camera:add (nuvens, 7)
end 

for i = 0, 1 do 
	local chaoFundo = display.newImageRect ("imagens/chao.png", 4503/3, 613/3)
	chaoFundo.x = -256+(chaoFundo.width*i)
	chaoFundo.y = 600
	camera:add (chaoFundo, 6)
end 

for i = 0, 6 do
	local arvoreFundo = display.newImageRect ("imagens/tree.png", 1024/4, 1024/4)
	arvoreFundo.x = -256 + (350*i)
	arvoreFundo.y = 450
	camera:add (arvoreFundo, 6)
end 

for i = 0, 1 do 
	local chaoMeio = display.newImageRect ("imagens/chao.png", 4503/3, 613/3)
	chaoMeio.x = -256+(chaoMeio.width*i)
	chaoMeio.y = 650
	camera:add (chaoMeio, 4)
end 

for i = 0, 6 do
	local arvoreMeio = display.newImageRect ("imagens/tree.png", 1024/4, 1024/4)
	arvoreMeio.x = math.random (20, 1280)*i
	arvoreMeio.y = 500 
	camera:add (arvoreMeio, 4)
end 

for i = 0, 20 do
	local chao = display.newImageRect ("imagens/chao.png", 4503/3, 613/3)
	chao.x = display.contentCenterX *i 	
	chao.y = 700
	physics.addBody (chao, "static", {friction=5, box={x=0, y=0, halfWidth=chao.width/2, halfHeight=chao.height/5}})
	camera:add (chao, 1)
end

for i = 0, 20 do 
	local arvore = display.newImageRect ("imagens/tree.png", 1024/4, 1024/4)
	arvore.x = math.random (-30, 2000)*i
	arvore.y = 550
	camera:add (arvore, 1)
end 

-- adicionar o player na tela. 
local player = playerScript.novo ()
 camera:add (player, 1)


-- definindo o "parallax" (perspectiva) de cada cena. É definido de forma decrescente.
camera:setParallax (1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.1, 0 )

-- controla a fluidez da camera ao seguir o player.
camera.damping = 10 
-- altera o foco para o player 
camera:setFocus (player)
-- inicia a perseguição da camera.
camera:track ()


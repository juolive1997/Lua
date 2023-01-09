local player_script = require( "player" )

-- Solicita a biblioteca de camera virtual
local perspective = require ( "perspective" )

-- cria a camera através da função createView()
local camera = perspective.createView()
-- prepara e organiza os layers da camera
camera:prependLayer()


local physics = require( "physics" )
physics.start( )
physics.setGravity( 0, 15 )
-- physics.setDrawMode( "hybrid" )






local plano_fundo = display.newImageRect( "imagens/bg.jpg", 509, 360 )
plano_fundo.x = 240
plano_fundo.y = 160
camera:add( plano_fundo, 8 )



local sol = display.newImageRect( "imagens/sun.png", 96, 96 )
sol.x = 400
sol.y = 20
camera:add( sol, 7 )



for i=0,4 do
	local nuvens = display.newImageRect( "imagens/cloud.png", 920*0.2, 384*0.2 )
	nuvens.x = 128*i
	nuvens.y = math.random(-60, 60)
	nuvens.alpha = 0.8
	camera:add( nuvens, 7 )	
end



for i=0,3 do
	local nuvens = display.newImageRect( "imagens/cloud.png", 920*0.3, 384*0.3 )
	nuvens.x = 128*i
	nuvens.y = math.random(-160, 160)
	nuvens.alpha = 0.8
	camera:add( nuvens, 7 )	
end



for i=0,1 do
	local chao = display.newImageRect( "imagens/chao.png", 4503*0.15, 613*0.15 )
	chao.x = -256+(chao.width*i)
	chao.y = 210
	camera:add( chao, 6 )	
end



for i=0,6 do
	local arvore = display.newImageRect( "imagens/tree.png", 96, 96 )
	arvore.x = -256+(128*i)
	arvore.y = 140
	camera:add( arvore, 6 )	
end



for i=0,1 do
	local chao = display.newImageRect( "imagens/chao.png", 4503*0.15, 613*0.15 )
	chao.x = -256+(chao.width*i)
	chao.y = 210
	camera:add( chao, 4 )
end



for i=0,6 do
	local arvore = display.newImageRect( "imagens/tree.png", 96, 96 )
	arvore.x = -256+(128*i)
	arvore.y = 140
	camera:add( arvore, 4 )	
end



for i=0,4 do
	local chao = display.newImageRect( "imagens/chao.png", 4503*0.15, 613*0.15 )
	chao.x = -256+(chao.width*i)
	chao.y = 230
	chao.id = "chao"
	physics.addBody( chao, "static", { friction=5, box= { x=0, y=0, halfWidth=chao.width/2, halfHeight=chao.height/5}} )
	camera:add( chao, 1 )
end



for i=0,6 do
	local arvore = display.newImageRect( "imagens/tree.png", 96, 96 )
	arvore.x = -256+(128*i)
	arvore.y = 160
	camera:add( arvore, 1 )
end



local player = player_script.novo( 240, 0 )
camera:add( player, 1 )

-- as posições das virgulas representa os numeros das camadas( layers )
			  -- N° 1,  2 ,  3 ,  4 ,  5 ,  6 ,   7, 8
camera:setParallax( 1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.1, 0 ) -- Aqui alteramos o "Parallax" na ordem decres cente para cada layer
-- parallax é uma técnica que causa uma ilusão de profundidade nas interfaces.

camera.damping = 10 -- Controla a fluidez da camera ao seguir o player
camera:setFocus(player) -- Troca o foco para o player
camera:track() -- Inicia a perseguição da camera
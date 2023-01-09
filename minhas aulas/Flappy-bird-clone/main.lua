local physics = require( "physics")
physics.start()
physics.setGravity( 0 , 9.8 )
--physics.setDrawMode( "hybrid" ) 


-- A orden de criaçao dos grupos define a ordem das camadas

local grupo_fundo = display.newGroup()--  ultima camada
local grupo_jogo = display.newGroup() -- camada do meio
local grupo_HUD = display.newGroup() -- camada da frente

local plano_fundo = display.newImageRect("images/fundo.png", 480*2, 320*2 )
plano_fundo.x  = 150
plano_fundo.y  = 250
grupo_fundo:insert(  plano_fundo )

local arvore = display.newImageRect("images/tree.png", 100, 100 )
arvore.x = 500
arvore.y = 360
grupo_fundo:insert( arvore )

local function mover_arvore()
	transition.to( arvore, { x=-400, time=2000, onComplete=function ()
	    arvore.x = 200
	    mover_arvore()
	end})   
end
mover_arvore()


local player = display.newImageRect( "images/Angry-Bird.png", 34, 34  )
player.id = "Angry-Bird"
player.x = 80
physics.addBody( player,"dynamic" )
grupo_jogo:insert( player )


local function pular ( event )
	--print( event.phase )
	if ( event.phase == "began" ) then
		player:setLinearVelocity( 0, -150 )
	end
end
Runtime:addEventListener( "touch", pular )


local function gerar_obstaculo_baixo()

	local sorteio_y = math.random(0,150)
	local rect = display.newImageRect( "images/pipe.png", 139*0.5, 515*0.7)
	rect.x = 600
	rect.y = 350+sorteio_y
	grupo_jogo:insert( rect )

	rect.id = "obstaculo"
	physics.addBody( rect, "kinematic", {box={ halfWidth=23, halfHeight=175 } } )
	grupo_jogo:insert( rect )
	-- transiciona o objeto para algum lugar
	transition.to( rect, { x=-100, time=4000, onComplete= function()
 	   --se auto remove ao completa a transicao
   	   display.remove( rect )
    end } )

end 
timer.performWithDelay( 1600, gerar_obstaculo_baixo , 0 )


local function gerar_obstaculo_cima()
	local sorteio_y = math.random(0 ,150)
	local rect = display.newImageRect( "images/pipe.png", 139*0.5, 515*0.7 ) 
    rect.x = 600
    rect.y = -200+sorteio_y
    rect.rotation =180
	rect.id ="obstaculo"
   physics.addBody( rect, "kinematic", {box={ halfWidth=23, halfHeight=175 } } )
	grupo_jogo:insert( rect )
	-- transiciona o objeto para algum lugar
	transition.to( rect, { x=-100, time=4000, onComplete=function()
 	   --se auto remove ao completa a transicao
   	    display.remove( rect )
    end } )
    
local pontos_obstaculo = display.newRect( 600, 160, 2, 360 )
    pontos_obstaculo.id ="pontos"
    pontos_obstaculo.alpha = 0
    physics.addBody( pontos_obstaculo, "kinematic", { isSensor=true } )
    transition.to( pontos_obstaculo, { x=-100, time=4000, onComplete= function()
 	   --se auto remove ao completa a transicao
   	 	display.remove(pontos_obstaculo )
    end } )
end
timer.performWithDelay( 1600, gerar_obstaculo_cima, 0 )

local pontos = 0 
local pontos_texto = display.newText( { text="Pontos: ".. pontos, x=240, y=60, font=nil, fontSize=30 } )
grupo_HUD:insert( pontos_texto  )

local function verificar_colisao( event )
	print( event.phase )
	if ( event.phase == "began" ) then
		print( "objecto 1" , event.object1.id )
		print( "objecto 2" , event.object2.id )

		if( event.object1.id == "Angry-Bird" and event.object2.id == "obstaculo" ) then
			display.remove( event.object1)
			Runtime:removeEventListener( "touch" , pular )

		elseif ( event.object1.id == "Angry-Bird" and event.object2.id == "pontos" ) then
			display.remove( event.object2 )
			pontos = pontos + 50
			pontos_texto.text = "Pontos: " .. pontos
        end
	end		
end
Runtime:addEventListener("collision", verificar_colisao )
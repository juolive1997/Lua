-- local helloWorld = display.newText ("Hello World!", 80, 80, native.systemFont, 20, center )

-- local opcoes = { 
-- 	text = "Olá Mundo!", 
-- 	x = 80,
-- 	y = 170, 
-- 	font = Arial, 
-- 	fontSize = 20, 
-- 	align = "right" }

-- local meuTexto = display.newText ( opcoes )

-- display.newRoundedRect (80, 120, 100, 30, 10 )

-- display.newLine (300, 330, 30, 100 )

-- display.newLine (20, 20, 300, 20 )

-- -- display.newLine (20, 20, 20, 300 )

-- local localizacaoX = 235
-- local localizacaoY = 100
 
-- local vertices = { 0,-110, 27,-35, 105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35, }

-- local estrela = display.newPolygon (localizacaoX, localizacaoY, vertices )

-- local textoRelevo = display.newEmbossedText( "Hello", 150, 300, native.systemFont, 40 )
-- textoRelevo:setFillColor( 0.5 )
-- textoRelevo:setText( "Hello World!" )
 
-- local color = 
-- {
--     highlight = { r=1, g=1, b=1 },
--     shadow = { r=0.3, g=0.3, b=0.3 }
-- }
-- textoRelevo:setEmbossColor( color )



-- local quadrado = display.newRect (250, 250, 50, 50)
-- quadrado:setFillColor (0.2, 0.5, 1, 1, 0.5)

-- local circulo = display.newCircle (180, 250, 30 )
-- circulo:setFillColor (0.5)

-- local retangulo = display.newRect (100, 250, 50, 70 ) 
-- retangulo:setFillColor (0, 1, 0.3)


-- local gradient = {
--     type="gradient",
--     color1={ 1, 0.1, 0.9 }, color2={ 0.8, 0.8, 0.8 }, direction="down"
-- }
-- estrela:setFillColor( gradient )



-- local gradient = {
--     type="gradient",
--     color1={ 1, 0, 0 }, color2={ 0.8, 0, 1 }, direction="left"
-- }
-- meuTexto:setFillColor( gradient )



-- local localizacaoX = 235
-- local localizacaoY = 200
 
-- local vertices = { 0,-60, 30,-60, 30,-35, }

-- local triangulo = display.newPolygon (235, 200, { 0,-60, 30,-60, 30,-35, } )



-- circulo.fill.effect = "generator.sunbeams"
 
-- circulo.fill.effect.posX = 0.5
-- circulo.fill.effect.posY = 0.5
-- circulo.fill.effect.aspectRatio = ( circulo.width / circulo.height )
-- circulo.fill.effect.seed = 0
----------------------------------------------------------------------------------
-- local circulo1 = display.newCircle (150, 50, 30 )
-- circulo1:setFillColor (0.5)
-- transition.to (circulo1, {time=3000, y=400, delta=true }) 

-- local circulo2 = display.newCircle (80, 50, 30 )
-- circulo2:setFillColor (0.5)
-- transition.to (circulo2, {time=3000, y=400})

-- local circulo3 = display.newCircle (200, 50, 30 )
-- transition.to (circulo3, {time=3000, y=400, iterations=4, transition=easing.outElastic})

-- local retangulo = display.newRect (200, 250, 50, 70 ) 
-- retangulo:setFillColor (0, 1, 0.3)
-- transition.to (retangulo, {time=3000, rotation=45, yScale=2, alpha=0.5} )
-- local physics = require ("physics")
-- physics.start ()
-- local chao = display.newRect (display.contentCenterX, 450, 500, 20)
-- physics.addBody (chao, "static")

-- local circulo1 = display.newCircle (150, 50, 30 )
-- physics.addBody (circulo1, "dynamic", {density=1.5, friction=0.1})
-- --circulo1.gravityScale = 5
-- --circulo1.linearDamping = 5
-- --circulo1:setLinearVelocity (-20, 15)
-- --circulo1:applyForce(1000, 500)
-- circulo1:applyAngularImpulse (150, 0)

-- local circulo2 = display.newCircle (80, 50, 30 )
-- physics.addBody (circulo2, "kinematic")

local function detectarTap( event )
 
    -- Código executado quando o botão é tocado.

    print( "Objeto tocado: " .. tostring(event.target) )  -- "event.target" é o objeto tocado
    -- tostring: para sequenciar
    return true
   -- "zera" todos os dados depois da função executada.
end -- fecha a local function.
 
local botaoTap = display.newRect( 200, 200, 200, 50 )
botaoTap:addEventListener( "tap", detectarTap )  -- Adicione um ouvinte "tap" ao objeto


local function tapDuplo( event )
 
 -- Quando (o parâmetro número de taps for igual a 2 ) então
    if ( event.numTaps == 2 ) then
    	--Print para mostrar que o tap duplo realmente foi detectado.
        print( "Objeto tocado duas vezes: " .. tostring(event.target) )
  -- Senão
    else
    	-- nada acontece.
        return true
    end -- fecha o else.
end -- fecha a function 
 
local botaoTapDuplo = display.newRect( 100, 100, 200, 50 )
botaoTapDuplo:addEventListener( "tap", tapDuplo )




local function detectarTouch (event)
	-- Tira print da localização x do toque
	print ("Localização X do toque" .. event.x)
	-- Tira print da localização y do toque
	print ("Localização Y do toque" .. event.y)
end 

local botao = display.newRect (100, 300, 200, 50)
botao:addEventListener ("touch", detectarTouch) -- Adiciona um listener "touch" ao objeto


local function fasesToque( event )
 
 -- se (a fase de evento for igual a "began") então 
    if ( event.phase == "began" ) then
        -- Código executado quando o botão é tocado
        print( "Objeto tocado = " .. tostring(event.target) )  -- "event.target" é o objeto tocado
-- entretanto se (a fase de evento for igual a "moved") então 
    elseif ( event.phase == "moved" ) then
        -- Código executado quando o toque é movido sobre o objeto
        print( "localização de toque nas seguintes coordenadas = X:" .. event.x .. ", Y:" .. event.y )
-- porém se (a fase de evento for igual a "ended") então 
    elseif ( event.phase == "ended" ) then
-- Código executado quando o toque levanta o objeto
        print( "Touch terminado no objeto: " .. tostring(event.target) )
    
    end -- fecha o if e os elseifs

    return true  -- Impede a propagação de toque/toque para objetos subjacentes
end -- fecha a function
 
local botaoTouch = display.newRect( 200, 400, 200, 50 )
botaoTouch:addEventListener( "touch", fasesToque ) -- Adiciona um listener "touch" ao objeto

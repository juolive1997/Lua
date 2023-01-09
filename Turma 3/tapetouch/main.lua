-- local function detectarTap( event )
 
--     -- Código executado quando o botão é tocado.

--     print( "Objeto tocado: " .. tostring(event.target) )  -- "event.target" é o objeto tocado
--     -- tostring: para sequenciar
--     return true
--    -- "zera" todos os dados depois da função executada.
-- end -- fecha a local function.
 
-- local botaoTap = display.newRect( 200, 200, 200, 50 )
-- botaoTap:addEventListener( "tap", detectarTap )  -- Adicione um ouvinte "tap" ao objeto


-- local function tapDuplo( event )
 
--  -- Quando (o parâmetro número de taps for igual a 2 ) então
--     if ( event.numTaps == 2 ) then
--     	--Print para mostrar que o tap duplo realmente foi detectado.
--         print( "Objeto tocado duas vezes: " .. tostring(event.target) )
--   -- Senão
--     else
--     	-- nada acontece.
--         return true
--     end -- fecha o else.
-- end -- fecha a function 
 
-- local botaoTapDuplo = display.newRect( 100, 100, 200, 50 )
-- botaoTapDuplo:addEventListener( "tap", tapDuplo )


-- local function detectarTouch (event)

-- 	print ("Localização X do toque" .. event.x)
-- 	print ("Localização Y do toque" .. event.y)
-- end 

-- local botao = display.newRect (100, 300, 200, 50)
-- botao:addEventListener ("touch", detectarTouch)


-- local function fasesToque( event )
	 
-- -- se (a fase de evento for igual "began" ) então 
-- 	 if ( event.phase == "began" ) then
-- 	 	 print("Objeto tocado = " .. tostring(event.target) )
-- -- entretanto (se a fase de evento for igual a "moved" ) então
-- 	 elseif ( event.phase == "moved" ) then
-- 	 	print( "localização de toque nas seguintes coordenadas = X:" .. event.x .. ", Y:" .. event.y )
-- -- porém (se a fase de evento for igual a "ended" ) então 
-- 	 elseif ( event.phase == "ended" or "cancelled" ) then
-- 	 	print( "Touch terminado no objeto: " .. tostring(event.target) )

-- 	 end -- fecha o if 

-- 	 return true 
-- end -- fecha a function fasesToque

-- local botaoTouch = display.newRect (200, 400, 200, 50)
-- botaoTouch:addEventListener ("touch", fasesToque)

--------------------------------------------------------------------------------
--Para utilizar o multitouch precisamos habilitar primeiramente.
system.activate ("multitouch") 

--Crie um objeto.
local newRect1 = display.newRect( display.contentCenterX, display.contentCenterY, 280, 440 )
newRect1:setFillColor( 1, 0, 0.3 )
 
-- Evento de touch
local function touchListener( event )
 
    print( "Fase de toque: " .. event.phase )
    print( "Localização X: " .. tostring(event.x) .. ", Localização Y: " .. tostring(event.y) )
    print( "ID de toque exclusivo: " .. tostring(event.id) )
    print( "----------" )
    return true
end
 
-- adicione o evento de touch ao objeto.
newRect1:addEventListener( "touch", touchListener )

--Propagação de toque. 

local function myTouchListener( event )
 
    if ( event.phase == "began" ) then
        -- Código executado quando o botão é tocado
        print( "Objeto tocado = " .. tostring(event.target) )  -- "event.target" é o objeto tocado
    end
    return true  -- Impede a propagação de tap/touch para objetos subjacentes
end

 local myButton = display.newRect( 100, 100, 200, 50 )
myButton:addEventListener( "touch", myTouchListener )


local retangulo1 = display.newRect( display.contentCenterX, 160, 60, 60 )
retangulo1:setFillColor( 1, 0, 0.3 )
local retangulo2 = display.newRect( display.contentCenterX, 320, 60, 60 )
retangulo2:setFillColor( 0.3, 0, 1 )
 
-- Touch event listener
local function touchListener1( event )
 -- Se (a fase de evento for igual a "began") então 
    if ( event.phase == "began" ) then
    -- Altera-se o alpha do objeto que foi tocado.
        event.target.alpha = 0.5
        -- Definir foco no objeto
        display.getCurrentStage():setFocus( event.target )
 
    elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        event.target.alpha = 1
        -- Liberar o foco no objeto
        display.getCurrentStage():setFocus( nil )
    end
    return true
end
 
-- Adicione um ouvinte de toque a cada objeto
retangulo1:addEventListener( "touch", touchListener1 )
retangulo2:addEventListener( "touch", touchListener1 )












-- Solicita a física dentro do script atual
local physics = require("physics")
-- Iniciar a fisica no script
physics.start()
-- Altera a gravidade X e gravidade Y
physics.setGravity( 0, 10 )

physics.setDrawMode( "debug" ) -- hybrid/debug/normal


local bg = display.newImageRect ("images/bg.jpg", 1920*0.3, 1080*0.3)
bg.x = 240
bg.y = 160

local function criar_itens ()
local largura = 563*0.1
local potion = display.newImageRect( "images/potion.png", largura, 561*0.1 )
potion.x = math.random(50, 400)
potion.y = 40
physics.addBody (potion, "dynamic", {radius= largura/2})
end
timer.performWithDelay( 400, criar_itens, 0 )

local ground = display.newRect (240, 320, 480, 40 )
physics.addBody( ground, "static" )
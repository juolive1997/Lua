local PlayerClasse = require( "Player" )
local InimigoClasse = require ("Inimigo")
local HUDClasse = require( "HUD" )
local ColetavelClasse = require( "Coletavel" )

local physics = require( "physics" )
physics.start( )
physics.setGravity( 0, 15 )
-- physics.setDrawMode( "normal" )


local plano_fundo = display.newImageRect( "imagens/bg.png", 800/1.6, 600/1.6 )
plano_fundo.x = 240
plano_fundo.y = 160

local hud = HUDClasse.novo()


local chao = display.newImageRect( "chao.png", 1503, 150 )
chao.x = 240
chao.y = 350
chao.id = "chao"
physics.addBody( chao, "static", { friction = 2, box = { x = 0, y = 0, halfWidth = 480, halfHeight = 40, angle = 0 } } )

local inimigo = InimigoClasse.novo( 400, 250 )

	


local player = PlayerClasse.novo( 40, 200, hud )


timer.performWithDelay( 1000, function ()
	local moeda_1 = ColetavelClasse.nova_moeda( math.random( 0, 480 ), -100 )
end, 0, "timer_moeda" )






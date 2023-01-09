local physics = require ("physics")
physics.start()
physics.setDrawMode ("normal")

local chao = display.newRect (display.contentCenterX, 470, 500, 50)
physics.addBody (chao, "static")

local testeParticula = physics.newParticleSystem (
	{ 
		filename = "liquidParticle.png",
		radius= 2,
		imageRadius= 4
	})

local function onTimer (event)
testeParticula:createParticle (
	{	-- Determina onde a nova partícula é gerada.
		x= 0,
		y= 0, 
		-- Valores iniciais de velocidade para a nova partícula.
		velocityX= 256,
		velocityY= 480,
		-- Define a cor para a partícula nos valores RGBA
		color= {1, 0.2, 0.4, 1},
		-- Define quantos segundos a partícula permanece na tela anter de morrer. 
		lifetime= 32.0, 
		-- Define o comportamento da partícula.
		flags= {"water", "colorMixing"}
	})
end 

timer.performWithDelay (20, onTimer, 0)


testeParticula:createGroup (
	{
		x= 50,
		y= 0,
		color= {0, 0.3, 1, 1},
		halfWidth= 64,
		halfHeight= 32,
		flags= {"water", "colorMixing"}
	})

testeParticula:applyForce (0, -9.8 *testeParticula.particleMass)
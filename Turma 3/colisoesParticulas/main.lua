local physics = require ("physics")
physics.start ()


local plataforma = display.newRect (display.contentCenterX, 350, 160, 40)
physics.addBody (plataforma, "static")
plataforma.rotation = 10 

local testParticleSystem = physics.newParticleSystem (
	{		
	filename= "liquidParticle.png",
	radius= 2,
	imageRadius= 4
})

local function onTimer ()
	testParticleSystem:createParticle(
		{		
		x= display.screenOriginX-10,
		y= 100,
		velocityX= 80,
		velocityY= -200,
		color = {1, 0.2, 0.4, 1},
		lifetime= 32,
		flags= {"water", "colorMixing", "fixtureContactListener"}
		})
end 

timer.performWithDelay (20, onTimer, 40)

local function onCollision (self, event)
	if (event.phase == "began") then
		print ("Sistema de partícula: ", event.particleSystem)
	end 
end 

testParticleSystem.particleCollision = onCollision
testParticleSystem:addEventListener ("particleCollision")
local physics = require ("physics")
physics.start ()
physics.setGravity (0, 5)
physics.setDrawMode ("hybrid")

display.setStatusBar (display.HiddenStatusBar)

local plataforma = display.newRect (display.contentCenterX, 100, 100, 50)
physics.addBody (plataforma, "static")

local circulo1 = display.newCircle (display.contentCenterX+150, 180, 20)
physics.addBody (circulo1, "dynamic", {radius=20})

local circulo2 = display.newCircle (display.contentCenterX-100, 0, 20)
physics.addBody (circulo2, "dynamic", {radius=20})

local juntaCorda = physics.newJoint ("rope", plataforma, circulo1, 50, 100, 10, 50)

-- local juntaToque = physics.newJoint ("touch", circulo2, 10, 10)

-- local function moverJunta ()
-- 	circulo2.x = circulo2.x +10
-- end 

-- Runtime:addEventListener ("touch", moverJunta)
 --local juntaPolia = physics.newJoint("pulley", circulo1, circulo2, 0, 0, 0, 0, plataforma.x, plataforma.y, plataforma.x, plataforma.y, 1)

--local juntaRoda = physics.newJoint ("wheel", plataforma, circulo1, 0, plataforma.y, plataforma.x, plataforma.y)
--local juntaSolda = physics.newJoint ("weld", plataforma, circulo1, plataforma.x, plataforma.y)
--local juntaFriccao = physics.newJoint ("friction", plataforma, circulo1, 50, 20)
-- -- Junta de pivô 
-- -- 									("tipo de junta", objA, objB, joelho.x, joelho.y)
-- local juntaPivo = physics.newJoint ("pivot", circulo1, plataforma, 150, 30 )
-- -- Ativa o motor da junta.
-- juntaPivo.isMotorEnabled = true
-- -- Altera a velocidade do motor 
-- juntaPivo.motorSpeed = -500
-- -- Ativa o máximo do torque do motor.
-- juntaPivo.maxMotorTorque = 10000 
-- -- Define que as juntas possuem um limite de rotação
-- juntaPivo.isLimitEnabled = true
-- -- Define em graus os limites de rotação da junta. (horário, anti-horário)
-- juntaPivo:setRotationLimits (300, 300)

-- -- Retornar os valores de limite de rotação da junta.
-- local negLimit, posLimit = juntaPivo:getRotationLimits()
-- print (negLimit, posLimit)

-- ------------ Junta de distância.
-- -- Parâmetros: ("tipo de junta", objA, objB, localizaçãoX de A para B, localização Y de A para B, localização X de B para A, localização Y de B para A)
-- local juntaDistancia = physics.newJoint ("distance",circulo2, plataforma,circulo2.x, circulo2.y, plataforma.x, plataforma.y)
-- -- Ajuste de amortecimento da junta.
-- juntaDistancia.dampingRatio = 0.7
-- -- Ajuste de elasticidade da junta.
-- juntaDistancia.frequency = 1

-- ------------ Junta do pistão.
-- local plataforma2 = display.newRect (display.contentCenterX, 350, 100, 50)
-- physics.addBody (plataforma2, "static")

-- local circulo3 = display.newCircle (display.contentCenterX-100, 400, 20)
-- physics.addBody (circulo3, "dynamic", {radius=20})

-- -- Parâmetros ("nome da junta", objA, objB, localizaçãoX, localizaçãoY, angulo de movimentação X, angulo de movimentação Y)
-- local juntaPistao = physics.newJoint ("piston", plataforma2, circulo3, 0, 0, 0, -1)
-- -- Ativa o motor de movimentação linear da junta.
-- juntaPistao.isMotorEnabled = true 
-- -- Define a velocidade linear pretendida do motor.
-- juntaPistao.motorSpeed = 100
-- -- Especifica a força máxima do motor.
-- juntaPistao.maxMotorForce = 1

-- juntaPistao.isLimitEnabled = true 
-- -- local chao = display.newRect (display.contentCenterX, 450, 500, 50)
-- -- physics.addBody (chao, "static")

-- local juntaFriccao = physics.newJoint ("friction", corpoA, corpoB, âncoraX, âncoraY)

-- local juntaSolda = physics.newJoint ("weld", corpoA, corpoB, âncoraX, âncoraY)

-- local juntaRoda = physics.newJoint ("wheel", corpoA, corpoB, âncoraX, âncoraY, eixoX, eixoY)

-- local juntaPolia = physics.newJoint("pulley", corpoA, corpoB, penduloA_x, 
-- 										penduloA_y, penduloB_x, penduloB_y, corpoA_x, corpoA_y, 
-- 										corpoB_x, corpoB_y, ratio)

-- local juntaToque = physics.newJoint ("touch", corpo, âncoraX, âncoraY)

-- local juntaCorda = physics.newJoint ("rope", corpoA, corpoB, deslocamentoX_a, deslocamentoY_a, 
-- 										deslocamentoX_b, deslocamentoY_b )


-- local juntaEngrenagem = physics.newJoint ("gear", corpoA, corpoB, junta1, junta2, ratio)
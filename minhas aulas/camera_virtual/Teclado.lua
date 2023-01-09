local Teclado = {}

function Teclado.novo( objeto )

	local function verificar_tecla( event )
		
		print( event.keyName )

		if event.phase == "down" then -- se alguma tecla foi pressionada
			if event.keyName == "d" then -- se a tecla pressionada foi a "d"
				objeto.direcao = "direita"
				objeto:setSequence("correndo")
				objeto:play()
				objeto.xScale = 1
			
			elseif event.keyName == "a" then -- se a tecla pressionada foi a "d"
				objeto.direcao = "esquerda"
				objeto:setSequence("correndo")
				objeto:play()
				objeto.xScale = -1

			end

			if event.keyName == "space" then
				objeto.numero_pulo = objeto.numero_pulo +1
			
				if objeto.numero_pulo == 1 then 
					objeto:applyLinearImpulse( 0, -0.4, objeto.x, objeto.y )
				
				elseif objeto.numero_pulo == 2 then
					transition.to( objeto, { rotation=objeto.rotation+360, time=750 } )
					objeto:applyLinearImpulse( 0, -0.4, objeto.x, objeto.y )

				end

			end
			
		elseif event.phase == "up" then -- se eu soltei alguma tecla
			if event.keyName == "d" then -- se a tecla que soltei foi a "d"
				objeto.direcao = "parado"
				objeto:setSequence("parado")
				objeto:play()
			
			elseif event.keyName == "a" then
				objeto.direcao = "parado"
				objeto:setSequence("parado")
				objeto:play()

			end

		end

	end
	Runtime:addEventListener( "key", verificar_tecla  )


	local function verificar_direcao()
		-- Pega a velocidade X e Y atual do objeto 60 vezes por segundo
		-- O getLinearVelocity retorna 2 valores
		local velocidade_x, velocidade_y = objeto:getLinearVelocity()

		if objeto.direcao == "direita" and velocidade_x <= 200 then
			objeto:applyLinearImpulse( 0.2, 0, objeto.x, objeto.y )

		elseif objeto.direcao == "esquerda" and velocidade_x >= -200 then
			objeto:applyLinearImpulse( -0.2, 0, objeto.x, objeto.y )		

		end

	end
	Runtime:addEventListener( "enterFrame", verificar_direcao )
	
end


return Teclado





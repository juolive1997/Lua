local Teclado = {}

function Teclado.novo( player )

	local function verificar_tecla( event )
	
		if event.phase == "down" then -- se alguma tecla foi pressionada
			if event.keyName == "d" then -- se a tecla pressionada foi a "d"
				player.direcao = "direita"
				player:setSequence("correndo")
				player:play()
				player.xScale = 1
			
			elseif event.keyName == "a" then -- se a tecla pressionada foi a "d"
				player.direcao = "esquerda"
				player:setSequence("correndo")
				player:play()
				player.xScale = -1

			end

			if event.keyName == "space" then
				player.numero_pulo = player.numero_pulo +1
			
				if player.numero_pulo == 1 then 
					player:applyLinearImpulse( 0, -0.4, player.x, player.y )
				
				elseif player.numero_pulo == 2 then
					transition.to( player, { rotation=player.rotation+360, time=750 } )
					player:applyLinearImpulse( 0, -0.4, player.x, player.y )
					print( "player rotation: " .. player.rotation )

				end

			end
			
		elseif event.phase == "up" then -- se eu soltei alguma tecla
			if event.keyName == "d" then -- se a tecla que soltei foi a "d"
				player.direcao = "parado"
				player:setSequence("parado")
				player:play()
			
			elseif event.keyName == "a" then
				player.direcao = "parado"
				player:setSequence("parado")
				player:play()

			end

		end

	end
	Runtime:addEventListener( "key", verificar_tecla  )


	local function verificar_direcao()
		-- Pega a velocidade X e Y atual do player 60 vezes por segundo
		-- O getLinearVelocity retorna 2 valores
		local velocidade_x, velocidade_y = player:getLinearVelocity()

		if player.direcao == "direita" and velocidade_x <= 200 then
			player:applyLinearImpulse( 0.2, 0, player.x, player.y )

		elseif player.direcao == "esquerda" and velocidade_x >= -200 then
			player:applyLinearImpulse( -0.2, 0, player.x, player.y )		

		end

	end
	Runtime:addEventListener( "enterFrame", verificar_direcao )
	
end


return Teclado





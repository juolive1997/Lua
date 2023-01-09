local Teclado = {}

function Teclado.novo ( player )

	local function verificarTecla (event)

		-- detectar quando alguma tecla é pressionada.
		if event.phase == "down" then 
			if event.keyName == "d" then -- verifica se a tecla pressionada foi o D. 
				player.direcao = "direita" 
				player:setSequence ( "correndo") -- sequencia da Sprite.
				player:play()
				player.xScale = 1 -- personagem virado para a direita.


			elseif event.keyName == "a" then 
				player.direcao = "esquerda"
				player:setSequence ("correndo") 
				player:play ()
				player.xScale = -1 

			end -- fecha o keyName

			if event.keyName == "space" then 
				player.numeroPulo = player.numeroPulo + 1

				if player.numeroPulo == 1 then 
					player:applyLinearImpulse (0, -0.4, player.x, player.y)

				elseif player.numeroPulo == 2 then 
					transition.to (player, {rotation=player.rotation+360, time=750 } )
					player:applyLinearImpulse (0, -0.4, player.x, player.y )
					player.numeroPulo = 0
						end -- fecha o numeroPulo


			end -- fecha o keyName

			elseif event.phase == "up" then -- verifica se alguma tecla foi solta
				if event.keyName == "d" then 
						player.direcao = "parado"
					player:setSequence ("parado")
					player:play ()


				elseif event.keyName == "a" then
					player.direcao = "parado"
					player:setSequence ("parado")
					player:play ()

				elseif event.keyName == "space" then 
					player.direcao = "parado"
					numeroPulo = 0
					player:setSequence ("parado")
					player:play()

				end -- fecha o keyName

		end -- fecha o event.phase

	end -- fecha a function verificarTecla

	Runtime:addEventListener ("key" , verificarTecla)

		local function verificarDirecao ()

			-- Pega a velocidade X e Y atual do player 60 vezes por segundo.
				-- getLinearVelocity retorna 2 valores. 
			local velocidadeX, velocidadeY = player:getLinearVelocity()

			if player.direcao == "direita" and velocidadeX <= 200 then 
				player:applyLinearImpulse ( 0.2, 0, player.x, player.y )

			elseif player.direcao == "esquerda" and velocidadeX >= -200 then 
				player:applyLinearImpulse ( -0.2, 0, player.x, player.y )


			end -- fecha o if 

		end -- fecha a function 

		Runtime:addEventListener ("enterFrame", verificarDirecao)

end -- fecha a function novo 


return Teclado 
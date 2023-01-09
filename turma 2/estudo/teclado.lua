local Teclado = {}

function Teclado.novo (player)

	local function verificarTecla (event)


		if event.phase == "down" then 
			if event.keyName == "d" then 
				player.direcao = "direita"
				player:setSequence ("andando")
				player:play ()
				player.xScale = 1

			elseif event.keyName == "a" then 
				player.direcao = "esquerda"
				player:setSequence ("andando")
				player:play ()
				player.xScale = -1 
			end 

			if event.keyName == "space" then 
				player.numeroPulo = player.numeroPulo +1 
				player:setSequence ("pulo")
				player:play ()

				if player.numeroPulo == 1 then 
					player:applyLinearImpulse (0, -3, player.x, player.y )

				elseif player.numeroPulo == 2 then 
					transition.to (player, {rotation=player.rotation+360, time=750 } )
					player:applyLinearImpulse (0, -3, player.x, player.y)
					player.numeroPulo = 0
				end -- fecha o if numeroPulo

			end -- fecha o if keyName

			elseif event.phase == "up" then
				if event.keyName == "d" or "a" then 
					player.direcao = "parado"
					player:setSequence ("parado")
					player:play ()
				elseif event.keyName == "space" then
					player.direcao = "parado"
					player:setSequence ("parado")
					player:play ()
					player.numeroPulo = 0 

				end -- fecha o if keyName

		end -- fecha o event.phase
	end -- fecha a function verificarTecla

Runtime:addEventListener ("key", verificarTecla)

	local function verificarDirecao ()

		if not (player.x == nil ) then
			-- Pega a velocidade X e Y atual do player 60 vezes por segundo.
				-- getLinearVelocity retorna 2 valores. 
			local velocidadeX, velocidadeY = player:getLinearVelocity()

			if player.direcao == "direita" and velocidadeX <= 200 then 
				player:applyLinearImpulse ( 0.2, 0, player.x, player.y )

			elseif player.direcao == "esquerda" and velocidadeX >= -200 then 
				player:applyLinearImpulse ( -0.2, 0, player.x, player.y )


			end -- fecha o if 
		end -- fecha o if not  

		end -- fecha a function 

		Runtime:addEventListener ("enterFrame", verificarDirecao)


end -- function teclado 

return Teclado 
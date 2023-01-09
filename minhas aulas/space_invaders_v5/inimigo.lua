local inimigo = {}

function inimigo.novo( grupo_jogo )
	
	local direcao_todos_inimigos = "direita"

	local function criar_inimigo( x_inicial, y_inicial )

		local inimigo = display.newImageRect( "imagens/nave-inimiga.png", 640*0.10, 366*0.10 )
		inimigo.x = x_inicial
		inimigo.y = y_inicial
		-- Variável de controle de direção

		inimigo.id = "inimigo"
		physics.addBody( inimigo, "kinematic" )

		grupo_jogo:insert( inimigo )


		local function inimigo_atirar()
			print("inimigo atirou!")
			local projetil_inimigo = display.newCircle( inimigo.x, inimigo.y+20, 4 )
			--  Altera a cor do objeto de forma geométrica
			-- 				   R,   G, B,  A
			projetil_inimigo:setFillColor( 0, 0.4, 1, 0.6 )
			physics.addBody( projetil_inimigo, "dynamic", { isSensor = true } )
			projetil_inimigo:setLinearVelocity( 0, 200 )
			projetil_inimigo.id = "projetil_inimigo"
			grupo_jogo:insert( projetil_inimigo )
		end
		inimigo.timer_atirar = timer.performWithDelay( math.random(3000, 8000), inimigo_atirar, 0 )


		local function movimentar_inimigo()

			if not ( inimigo.x == nil ) then -- se o inimigo está vivo
			--  Se ( Direção do inimigo for igual a o valor estipulado ) then
				if ( direcao_todos_inimigos == "direita" ) then
					inimigo.x = inimigo.x +1

					-- Verifica se chegou no limite a direita
					if ( inimigo.x >= 320 ) then
						direcao_todos_inimigos = "esquerda"
					end

				elseif ( direcao_todos_inimigos == "esquerda" ) then
					inimigo.x = inimigo.x -1

					-- Verifica se chegou no limite a esquerda
					if ( inimigo.x <= 0 ) then
						direcao_todos_inimigos = "direita"
					end
							
				end -- Fim do block if

			else -- qualquer outra coisa faça isso
				print( "Inimigo morreu!" )
				-- Removeu o enterFrame que movimentava o inimigo
				Runtime:removeEventListener( "enterFrame", movimentar_inimigo )
			
			end	

		end
		-- A função associada a um evento de enterFrame
		-- é chamada 60 vezes a cada 1 segundo
		-- Runtime ( tempo de execução ), representa o meu aplicativo todo
		Runtime:addEventListener( "enterFrame", movimentar_inimigo )

	end
	
	-- Ultimo grupo inimigos
	criar_inimigo( 60, 60 )
	criar_inimigo( 130, 60 )
	criar_inimigo( 200, 60 )
	criar_inimigo( 270, 60 )

	-- inimigos da meio
	criar_inimigo( 95, 120 )
	criar_inimigo( 165, 120 )
	criar_inimigo( 235, 120 )

	-- inimigos da frente
	criar_inimigo( 165, 180 )
end



-- Retorna o objeto para a tela que o chamou
return inimigo
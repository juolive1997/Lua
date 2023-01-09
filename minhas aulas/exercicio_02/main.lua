local bg = display.newImageRect( "images/bg.jpg", 564*2, 205*2 )
bg.x = 320/2
bg.y = 200

local player = display.newImageRect( "images/fada.png", 367/3, 612/3 )
player.x = 80
player.y = 200
player.direcao = "parado"

local function trocar_direcao_player ( event )
	if (event.phase == "began") then
		if (event.y < 160 ) then 
			player.direcao = "cima"

		elseif (event.y > 160 ) then 
			player.direcao = "baixo"

		end 	

	elseif (event.phase == "ended" ) then 
		player.direcao = "parado"
		print ("Player está: ", player.direcao)
	
	end
end

Runtime:addEventListener( "touch", trocar_direcao_player )

local function mover_player ()
	if (player.direcao == "cima") then 
		player.y = player.y - 1

	elseif (player.direcao == "baixo" ) then 
			player.y = player.y +1
	end 


end
Runtime:addEventListener ("enterFrame", mover_player )

local function gerar_item ()
	-- Sorteia um valor aleatorio de um valor inicial até um valor final.
	-- o valor inicial deve ser sempre maior que o final.
	local sorteio_x = math.random(0, 480 )
		print( "sorteio x:" , sorteio_x )
	local sorteio_y = math.random(0, 320)
		print( "sorteio y:" , sorteio_y )

	local item = display.newImageRect( "images/borboleta-02.png", 1024/15, 1024/15)
	item.x = sorteio_x
	item.y = sorteio_y
end 
timer.performWithDelay (2000, gerar_item, 0)

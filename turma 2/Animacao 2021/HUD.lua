local HUD = {}

function HUD.novo()
	
	local grupo_hud = display.newGroup()

	local pontos = 0
	local pontos_texto = display.newText( { text="Pontos: " .. pontos, x=120, y=40, font=nil, fontSize=26 } )

	grupo_hud.somar = function()
		pontos = pontos +1
		pontos_texto.text = "Pontos: " .. pontos
	end

	return grupo_hud
end


return HUD
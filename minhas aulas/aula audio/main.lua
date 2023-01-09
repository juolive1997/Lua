-- informações de como o audio deve ser reproduzido
local parametros_audio_tiro = { time = 2000, fadein = 200 }

-- loadSound é melhor utilizado com sons curtos
local arquivo_audio_tiro = audio.loadSound( "Audio/tiro.wav" )

-- Parametros audio bg
local parametros_audio_bg = { channel = 1, fadein = 0, time = 10000 }

-- Utilizado para Musicas
local arquivo_audio_bg = audio.loadStream( "Audio/audio_bg.mp3" )


-- para o audio pelo timer
-- timer.performWithDelay( 5000, function()
-- 	audio.pause( arquivo_audio_bg )
-- end, 1 )


local bt_audio_esquerda = display.newCircle( 60, 300, 32 )
bt_audio_esquerda:setFillColor( 1, 0, 0 )

local function tocar_audio_tiro( event )
	if ( event.phase == "began" ) then

		local canal_audio_tiro = audio.play( arquivo_audio_tiro, parametros_audio_tiro )
		print( canal_audio_tiro )
	end
end
bt_audio_esquerda:addEventListener( "touch", tocar_audio_tiro )




local bt_audio_direita = display.newCircle( 260, 300, 32 )
local canal_audio_bg
local audio_bg_tocando = false

local function tocar_musica_bg( event )
	if ( event.phase == "began" ) then
		if ( audio_bg_tocando == false ) then
			canal_audio_bg = audio.play( arquivo_audio_bg, parametros_audio_bg )
			audio_bg_tocando = true
		else
			audio.resume( canal_audio_bg )
		end
		
	elseif( event.phase == "ended" ) then
		audio.pause( canal_audio_bg )

	end
end
bt_audio_direita:addEventListener( "touch", tocar_musica_bg )




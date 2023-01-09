-- utilizado para sons curtos.
-- Parâmetros: 					("pasta/arquivo.formato")
local audioTiro = audio.loadSound ("Audio/tiro.wav")

-- Utilizado para músicas/sons longos.
local audioBg = audio.loadStream ("Audio/audio_bg.mp3")

-- Reservando um canal para música de fundo.
audio.reserveChannels (1)

-- Controlar o volume do canal 
-- 				(volume, {canal=N})
audio.setVolume (0.3, {channel=1})

audio.play (audioBg, {channel=1, loops = -1})

local botaoEsquerda = display.newCircle (60, 300, 32)
botaoEsquerda:setFillColor (1, 0, 0)

local function tocarTiro (event)
	if (event.phase == "began") then
		audio.pause (audioBg)
		local canalTiro = audio.play (audioTiro)
	elseif (event.phase == "ended") then 
		audio.resume (audioBg)
	end 
end 

botaoEsquerda:addEventListener ("touch", tocarTiro)


-- carregar a biblioteca composer no script.
local composer = require ("composer") 

display.setStatusBar (display.HiddenStatusBar)

math.randomseed (os.time() )

-- reservando um canal para música de fundo. 
audio.reserveChannels (1)

-- controla o volume do canal.
--	             (volume, {canal})
audio.setVolume (0.3, {channel=1} ) 

-- cria o comando da cena Menu
composer.gotoScene ("menu")
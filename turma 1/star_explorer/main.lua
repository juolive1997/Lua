local composer = require ("composer")

display.setStatusBar( display.HiddenStatusBar )

math.randomseed( os.time () )

composer.gotoScene( "menu" )

audio.reserveChannels (1) -- reserva um canal de música ao logo do jogo
audio.setVolume (0.3,{channel=1}) -- diminui o volume do audio em 50% no canal 1

audio.reserveChannels (2)
audio.setVolume (0.3,{channel=2})

audio.reserveChannels (3)
audio.setVolume (0.3,{channel=3})
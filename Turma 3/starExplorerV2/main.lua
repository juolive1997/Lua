local composer = require ("composer")

audio.reserveChannels (1)
audio.setVolume (0.3, {channel=1})

-- Faz com que os math.randoms não tenham um padrão previsível.
math.randomseed (os.time())

display.setStatusBar (display.HiddenStatusBar)

composer.gotoScene ("menu")
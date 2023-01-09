local composer = require ("composer") 

display.setStatusBar (display.HiddenStatusBar)

math.random (os.time() )

audio.reserveChannels (1)

audio.setVolume (0.0, {channel=1})

composer.gotoScene ("menu")
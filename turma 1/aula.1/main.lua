local pontos = 0

--         comando               ("pasta/arquivo.formato", dimensões)
local bg = display.newImageRect ("imagens/bg.jpg",626,417*1.5)
-- definir local da imagem horizontalmente
	bg.x = display.contentCenterX -- comando para centralizar imagem na tela.
-- definir local da imagem verticalmente
	bg.y = display.contentCenterY 

local balao = display.newImageRect ("imagens/balloon.png", 260/3,340/3)
	balao.x = 320/2
	balao.y = 300

local plataforma = display.newImageRect ("imagens/platform.png", 300+70, 50)
	plataforma.x = display.contentCenterX
	plataforma.y = 470


--variavel texto =              ("o que quero mostrar", x, y, fonte, tamanho da fonte)
local pontosText = display.newText ("Pontos: " , 320/2, 50, arial, 30)

-- função física = carrega a fisíca no dispositivo.
local physics = require ("physics")
-- inicia a física 
	physics.start( )
-- adiciona física a variavel descrita (variavel, "tipo de física")
	physics.addBody (plataforma, "static")
	--                       para objetos redondos, força que o objeto irá rebater após o choque
	physics.addBody( balao, "dynamic", {radius=50, bounce=0.5})

-- variável de função.
local function toque ()
	-- solicita impulso      (força direcionalx, direcionalY, onde será aplicada a força)
	balao:applyLinearImpulse( 0, -0.75, balao.x, balao.y )
	pontos = pontos +1
	print( pontos )
	pontosText.text = "Pontos: " .. pontos


end
-- variavel:adicionar evento ("nome do evento", função)
balao:addEventListener ( "tap", toque )

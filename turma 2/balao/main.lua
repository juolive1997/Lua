local physics = require ("physics") -- chamar a biblioteca de física. 
physics.start () -- inicia a física no código.
physics.setDrawMode( "normal" )
local pontos = 0 -- define o valor de 0 para a variável pontos.


-- incluir o plano de fundo. 
-- newImageRect = imagem que pode ser redimensionada
-- variável = display.newImageRect ("pasta/nomedoarquivo.formato", largura, altura )
local bg = display.newImageRect ("imagens/background.png", 360, 570)
-- localização horizontal. 
bg.x = display.contentCenterX -- coloca o arquivo no centro da linha. Horizontal.
bg.y = display.contentCenterY -- coloca o arquivo no centro da coluna. Vertical. 

--   							(váriavel, localização x (horizontal), localização y (vertical), fonte, tamanho do texto )
local pontosText = display.newText (pontos, display.contentCenterX, 20, Arial, 40)
-- trocar a cor do texto (vermelho, verde, azul, alfa)
pontosText:setFillColor (0, 0, 0)


local plataforma = display.newImageRect ("imagens/platform.png", 300, 50)
plataforma.x = display.contentCenterX
-- contentTop: leva o objeto para o topo da tela.
-- contentLeft : alinha a esquerda de acordo com o centro da imagem. 
-- leva o objeto para a parte debaixo da tela.
plataforma.y = display.contentHeight-25 
-- adicionar corpo (variável, "tipo de física")
physics.addBody (plataforma, "static")

local balao = display.newImageRect ("imagens/balloon.png", 112, 112)
balao.x = display.contentCenterX
balao.y = display.contentCenterY
-- adiciona transparência ao objeto. 
balao.alpha = 0.7
-- física dinâmica= objeto é corpo ativo no jogo, pode haver colisões com outros objetos. 
physics.addBody (balao, "dynamic", {radius=50, bounce=0.3})

--
local function sobe ()
-- Aplica um impulso de "empurrão" ao objeto.
-- valores:       (impulso x, impulso y, onde será aplicado o impulso x, onde será aplicado o impulso y)
	balao:applyLinearImpulse (0, -0.75, balao.x, balao.y )

end

balao:addEventListener ("tap", sobe)	


local function impulsoBotao ()
 	impulsoX = math.random (-2, 2)
 	balao:applyLinearImpulse (impulsoX, -0.75, balao.x, balao.y)
 	pontos = pontos + 1
 	pontosText.text = pontos
end

local botao = display.newImageRect ("imagens/button.png", 512/6, 512/6)
botao.x = display.contentCenterX
botao.y = display.contentHeight 
botao:addEventListener ("tap", impulsoBotao)

-- display.newRect = cria um novo retangulo. (localização X, localização Y, largura, comprimento )
local parede1 = display.newRect (2, 200, 5, 1000)
local parede2 = display.newRect (318, 200, 5, 1000)
local teto = display.newRect (160, -110, 1000, 50)
physics.addBody (parede1, "static")
physics.addBody (parede2, "static")
physics.addBody (teto, "static")
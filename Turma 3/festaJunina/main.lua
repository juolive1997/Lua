-- Adicionar nova imagem na tela: 
-- Comandos: display.newImageRect ("pasta/arquivo.formato", largura, altura)

local bg = display.newImageRect ("imagens/bg.jpg", 850*1.2, 850*1.2)
bg.x = display.contentCenterX  -- 768*0.5 
bg.y = display.contentCenterY -- centralizar a imagem na tela.
-- contentTop: leva o objeto/imagem para o topo da tela. 
-- contentLeft: alinha a esquerda de acordo com o centro da imagem.

local player = display.newImageRect ("imagens/player.png", 260, 300)
player.x = 350
player.y = 790 

local frango = display.newImageRect ("imagens/frango.png", 647*0.2, 385*0.2)
frango.x = 200
frango.y = 790 

-- Criando funções: 

local function esquerda ()
	player.x = player.x - 5
	frango.x = frango.x + 5
	player.xScale = 1 
end

local botaoEsquerda = display.newImageRect ("imagens/button.png", 360*0.4, 360*0.4)
botaoEsquerda.x = 600
botaoEsquerda.y = 900
botaoEsquerda.rotation = 180
botaoEsquerda:addEventListener ("tap", esquerda)

local function direita ()
	player.x = player.x + 5
	player.xScale = -1 
end 

local botaoDireita = display.newImageRect ("imagens/button.png", 360*0.4, 360*0.4)
botaoDireita.x = 700
botaoDireita.y = 900 
botaoDireita:addEventListener ("tap", direita)

local function cima ()
	player.y = player.y - 5
end

local botaoCima = display.newImageRect ("imagens/button.png", 360*0.4, 360*0.4)
botaoCima.x = 650
botaoCima.y = 800 
botaoCima.rotation = 270
botaoCima:addEventListener ("tap", cima)


local function baixo ()
	player.y = player.y +5 
end 

local botaoBaixo = display.newImageRect ("imagens/button.png", 360*0.4, 360*0.4)
botaoBaixo.x = 650
botaoBaixo.y = 1000
botaoBaixo.rotation = 90
botaoBaixo:addEventListener ("tap", baixo)
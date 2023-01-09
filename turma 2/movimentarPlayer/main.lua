local bg = display.newImageRect ("imagens/bg.jpg", 549*2, 309*2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local player = display.newImageRect ("imagens/player.png", 442/3, 564/3)
player.x = display.contentCenterX
player.y = 250

local numeroToques = 0
--                                  ("texto que aparece" .. variavel , x, y, fonte, tamanho)
local ToquesText = display.newText ("Número de toques: " .. numeroToques, 160, 480, Arial, 30)

local function contarToques ()
	numeroToques = numeroToques + 1 
	print ("Número de toques: " .. numeroToques)
	ToquesText.text = "Número de toques: " .. numeroToques -- atualização do texto de acordo com a execução da função.
end

-- Andar para cima
local function cima ( )
	player.y = player.y - 2
end

local botaoCima = display.newImageRect ("imagens/button.png", 360/4, 360/4)
botaoCima.x = 100
botaoCima.y = 30
botaoCima.rotation = 270
botaoCima:addEventListener ("touch", cima)
botaoCima:addEventListener ("tap", contarToques)

-- Andar para baixo
local function baixo ( )
	player.y = player.y + 2
	numeroToques = numeroToques +1
end

local botaoBaixo = display.newImageRect ("imagens/button.png", 360/4, 360/4)
botaoBaixo.x = 100
botaoBaixo.y = 100
botaoBaixo.rotation = 90
botaoBaixo:addEventListener ("touch", baixo)
botaoBaixo:addEventListener ("tap", contarToques)

-- Andar para esquerda
local function esquerda ( )
	player.x = player.x - 2
end

local botaoEsquerda = display.newImageRect ("imagens/button.png", 360/4, 360/4)
botaoEsquerda.x = 35
botaoEsquerda.y = 70
botaoEsquerda.rotation = 180
botaoEsquerda:addEventListener ("touch", esquerda)
botaoEsquerda:addEventListener ("tap", contarToques)
	

local function direita ( )
	player.x = player.x + 2
end

local botaoDireita = display.newImageRect ("imagens/button.png", 360/4, 360/4)
botaoDireita.x = 170
botaoDireita.y = 70
botaoDireita:addEventListener ("touch", direita)
botaoDireita:addEventListener ("tap", contarToques)



-- criar forma retangular :
--                       .novoRetangulo (x, y, altura, largura)
local botaoRetangular = display.newRect(60, 400, 48, 48)
botaoRetangular:addEventListener ("tap", contarToques)  -- "tap" referente a cliques.

-- adicionar texto na tela: 
--                                ({text="texto que aparece"} .. variavel, localização x, localização y, fonte, tamanho)
local ToquesTexto = display.newText ({text="Número de toques: " .. numeroToques, x=80, y=450, font=nil, fontsize=30})
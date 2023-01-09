local vidas = 5 

-- Operação de soma: 
vidas = vidas+1 
print ("Vidas: " .. vidas)

-- Operação de subtração: 
local pontos = 7 
pontos = pontos -1 
print ("Pontos: " .. pontos)

-- subtração entre variáveis.
vidas= vidas - pontos 
print ("Subtração vidas: " .. vidas)

-- soma entre variáveis.
local total = vidas + pontos
print ("Soma total: " .. total)

-- Operação de multiplicação: 
local moedas = 10 
moedas = moedas * 2
print ("Moedas: " .. moedas)

-- Operação de divisão:
local divi = 50
divi = divi / 2
print ("Divisão: " .. divi)


-- INCLUSÃO DE IMAGEM: 
-- Para incluir uma imagem é necessário saber: pasta que está a imagem, nome do arquivo, 
	--formato e dimensões.
-- variável =                        ("pasta/arquivo.formato", largura, altura)
local player = display.newImageRect ("imagens/player.png", 442*0.3, 564/3)
-- define a localização horizontal do objeto. 
player.x = display.contentCenterX -- quanto maior o número mais a direita.
-- define a localização vertical do objeto. 
player.y = display.contentCenterY -- quanto maior o número, mais pra baixo.
print ("Player X: " .. player.x)
print ("Player Y: " .. player.y)


local function direita ()
	player.x = player.x +2

print ("Player X: " .. player.x)
end 

local botao = display.newImageRect ("imagens/button.png", 360/3 ,360/3 )
botao.x = 200
botao.y = 400 
botao:addEventListener ("touch", direita)

local function esquerda ()
	player.x = player.x - 2
end

local botaoEsquerda = display.newImageRect ("imagens/button.png", 360/3 ,360/3 )
botaoEsquerda.x = 100
botaoEsquerda.y = 400 
botaoEsquerda:addEventListener ("touch", esquerda)
botaoEsquerda.rotation = 180 -- Faz a rotação do objeto N graus.









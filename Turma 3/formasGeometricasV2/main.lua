-- Criar um retângulo: 
-- comandos : display.newRect (localização X, localização y, largura, altura )
local retangulo = display.newRect (300, 80, 100, 70)

-- Criar um círculo: 
-- comandos: display.newCircle (x, y, radius(raio (metade do círculo)) )
local circulo = display.newCircle (150, 80, 50)

-- Criar um quadrado: 
-- comandos: display.newRect (x, y, largura, altura)
local quadrado = display.newRect (450, 80, 100, 100)


-- Criar um retangulo arredondado: 
-- Comandos: display.newRoundedRect (x, y, width, height, cornerRadius)
-- cornerRadius: os cantos são arredondados por um quarto de círculo desse valor de raio
local retanguloArredondado = display.newRoundedRect (600, 80, 100, 70, 30)
	
-- Criar um quadrado arredondado:
local quadradoArredondado = display.newRoundedRect (750, 80, 100, 100, 30)

-- Criar uma linha: 
-- comandos: display.newLine (xInicial, yInicial, xFinal, yFinais)

-- linha reta vertical: 
--                                 x, y,  x ,  y 
local vertical = display.newLine (20, 20, 20, 300)

local linhaTeste = display.newLine (50, 550, 1000, 550)
-- linha reta horizontal 
local horizontal = display.newLine (20, 20, 300, 20)

-- linha diagonal
local diagonal = display.newLine (300, 300, 30, 100)

-- Criar um polígono:
--Comandos: display.newPolygon (x, y, vertices)

local localizacaoX = 235
local localizacaoY = 300

local vertices = { 0,-110, 27,-35, 105,-35, 43,16, 65,90, 0,45, -65,90, 
-43,15, -105,-35, -27,-35, }

local estrela = display.newPolygon (localizacaoX, localizacaoY, vertices )

-- Criar novo texto: 
-- comandos: display.newText ("Texto que quero inserir", x, y, largura, altura, fonte, fontsize, alinhamento)
local helloWorld = display.newText ("Hello World!", 150, 500, native.systemFont, 50, center)

local opcoes = {
	text = "Olá Mundo!",
	x = 500, 
	y = 500, 
	font = "Arial", 
	fontSize = 50,
	align = "right"}

local meuTexto = display.newText ( opcoes )

-- Adicionar texto em relevo: 
--Comandos: display.newEmbossedText (opcoes)
--local opcoes = {
-- 	text = "Texto",
-- 	x = , 
-- 	y = , 
-- 	font = , 
-- 	fontSize = ,
-- align = "" }

local textoRelevo = display.newEmbossedText ("Hello", 150, 600, native.systemFont, 40)

local textoRelevo2 = display.newEmbossedText ("Hello", 300, 600, native.systemFont, 40)

-- adicionar cor no objeto/texto:
--  Comandos: 
-- variavel:setFillColor (cinza, vermelho, verde, azul, alfa )
textoRelevo2:setFillColor ( 0, 0.4 )

local color = {
	-- destaque (parte debaixo)
	highlight = {r = 1, g = 1, b = 1 }, 
	-- sombra 
	shadow = {r = 0.9, g = 0.4, b = 0.5 }
}

textoRelevo2:setEmbossColor ( color )
--                                (vermelho, verde, azul, alfa)
retanguloArredondado:setFillColor ( 0.5, 0.7, 0, 0.7)

-- utilizando todos os parametros 
quadrado:setFillColor (0., 0.5, 1, 1, 0.5 )

-- utilizando apenas um parâmetro, mexemos apenas no cinza. 
circulo:setFillColor (0.5)

-- utilizando 3 parametros 
--  				(vermelho, verde, azul)
retangulo:setFillColor (0, 1, 0.3)

--Gradiente: 
-- -- Comandos: 
-- local gradiente = {
-- 	type= "gradient",
-- 	color1= { , , }, color2= { , , }, direction= ""
-- }

local gradiente = 
	{type="gradient", color1= {1, 0.1, 0.9 } , color2= {0.8, 0.8, 0.8}, direction="down"}

estrela:setFillColor (gradiente)
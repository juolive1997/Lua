-- SOMA 
local limao = 10
limao = limao +1
print( "Limão: " .. limao )

-- SUBTRAÇÃO
local agua = 10
agua = agua -1
print ("Água: " .. agua)

-- soma entre variáveis
local limonada = limao + agua
print( "Limonada igual a: " .. limonada ) 

--subtração entre variáveis
local suco = limao - agua
print( "Suco de limão igual a: " .. suco ) 

-- MULTIPLICAÇÃO
local frango = 20
frango = frango * 3
print( "Frango: " .. frango )


-- DIVISÃO 
local arroz = 7 
arroz = arroz / 2
print ("Arroz: " .. arroz )

frango = display.newImageRect ("imagens/frango.png", 647/3, 385/3)
frango.x = display.contentCenterX
frango.y = display.contentCenterY

local function andar_direita ()
	frango.x = frango.x +2
end

local direita = display.newImageRect( "imagens/button.png", 1280/20, 1279/20 )
direita.x = 280
direita.y = 430
direita:addEventListener ("touch", andar_direita)

local function andar_esquerda ()
	frango.x = frango.x -2
end

local esquerda = display.newImageRect( "imagens/button.png", 1280/20, 1279/20 )
esquerda.x = 40
esquerda.y = 430
-- faz a rotação do objeto em x graus
esquerda.rotation = 180
esquerda:addEventListener( "touch", andar_esquerda )


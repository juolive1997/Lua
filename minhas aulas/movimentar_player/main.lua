local plano_fundo = display.newImageRect ("images/bg.jpg", 7680*0.1, 4320*0.1)
	plano_fundo.x = 320/2
	plano_fundo.y = 480/2

local Player = display.newImageRect("images/mario.png", 928/10, 1024/10)
	Player.x = 70
	Player.y = 350


local function direita_x ()
	Player.xScale = -1 --Altera a escala X do objeto
	Player.x = Player.x +2
	print ("Player X: " .. Player.x) 
end



--			Coloca uma imagem na tela ( "pasta/arquivo.png, largura,altura" )
local botao_direita = display.newImageRect ("images/button.png", 40, 40)
	botao_direita.x = 295
	botao_direita.y = 410
-- aplicar movimento conforme toca na tela.
botao_direita:addEventListener("touch", direita_x)

local function esquerda_x ()
	Player.xScale = 1
	Player.x = Player.x -2
	print ("Player X: " .. Player.x) 
end
	

local botao_esquerda = display.newImageRect ("images/button.png" , 40,40)
	botao_esquerda.x = 240
	botao_esquerda.y = 410
	botao_esquerda.rotation = 180
	botao_esquerda:addEventListener( "touch", esquerda_x )


local function cima_x ()
		Player.y = Player.y - 2
		print ("Player X: " .. Player.y)
end

local botao_cima = display.newImageRect ( "images/button.png", 40, 40)
	botao_cima.x = 270
	botao_cima.y = 380
	botao_cima.rotation = -90
	botao_cima:addEventListener( "touch", cima_x )



local function descer_x ()
	Player.y = Player.y + 2
	print( "Player X:" .. Player.y)
end

local botao_descer = display.newImageRect ("images/button.png", 40, 40)
	botao_descer.x = 270
	botao_descer.y = 440
	botao_descer.rotation = 90
	botao_descer:addEventListener( "touch", descer_x )


local function andar_diagonal_direita_cima () 
	direita_x ()
	cima_x ()
	print( "Player X:" .. Player.y)
end

local botao_diagonal_direita_cima = display.newImageRect ("images/button.png", 40, 40)
	botao_diagonal_direita_cima.x = 300
	botao_diagonal_direita_cima.y = 380
	botao_diagonal_direita_cima.rotation = 315
	botao_diagonal_direita_cima:addEventListener( "touch", andar_diagonal_direita_cima )


local function andar_diagonal_direita_baixo () 
	direita_x ()
	descer_x ()
	print( "Player X:" .. Player.y)
end

local botao_diagonal_direita_baixo = display.newImageRect ("images/button.png", 40, 40)
	botao_diagonal_direita_baixo.x = 300
	botao_diagonal_direita_baixo.y = 445
	botao_diagonal_direita_baixo.rotation = 400
	botao_diagonal_direita_baixo:addEventListener( "touch", andar_diagonal_direita_baixo )	


local function andar_diagonal_esquerda_baixo () 
	esquerda_x ()
	descer_x ()
	print( "Player X:" .. Player.y)
end

local botao_diagonal_esquerda_baixo = display.newImageRect ("images/button.png", 40, 40)
	botao_diagonal_esquerda_baixo.x = 240
	botao_diagonal_esquerda_baixo.y = 445
	botao_diagonal_esquerda_baixo.rotation = 150
	botao_diagonal_esquerda_baixo:addEventListener( "touch", andar_diagonal_esquerda_baixo )	

local function andar_diagonal_esquerda_cima () 
	esquerda_x ()
	cima_x ()
	print( "Player X:" .. Player.y)
end

local botao_diagonal_esquerda_cima = display.newImageRect ("images/button.png", 40, 40)
	botao_diagonal_esquerda_cima.x = 240
	botao_diagonal_esquerda_cima.y = 380
	botao_diagonal_esquerda_cima.rotation = 580
	botao_diagonal_esquerda_cima:addEventListener( "touch", andar_diagonal_esquerda_cima )	




-- Cria uma forma retangular              x,   y,   L,  A
local botao_retangular = display.newRect( 60, 427, 48, 48 )	
local numero_toques = 0 

-- Adicionar texto na tela                    texto que irá aparecer                    fonte    tamanho
local numero_toques_texto = display.newText( { text="Numero de Toques: " .. numero_toques , x=160, y=20, font=nil, fontSize=32} )
print( numero_toques_texto )


-- Contar toques na tela
local function contar_toques()
	numero_toques = numero_toques + 1
	print( numero_toques )
	numero_toques_texto.text = "Numero Toques: ".. numero_toques
end

botao_retangular:addEventListener( "touch", contar_toques )
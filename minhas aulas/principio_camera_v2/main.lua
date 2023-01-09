local player_script = require( "player" )


local grupo_fundo = display.newGroup( )
local grupo_meio = display.newGroup( )
-- Definimos a escala para todos os objetos que entrarem nesse grupo
grupo_meio:scale(0.6, 0.6)

local grupo_jogo = display.newGroup( )
local grupo_HUD = display.newGroup( )

local plano_fundo = display.newImageRect ( "imagens/sky.png", 960, 480)
plano_fundo.x = 240
plano_fundo.y = 160
grupo_fundo:insert( plano_fundo)


for i=0,10 do
	local arvore_meio = display.newImageRect( "imagens/tree.png", 256, 256)
	arvore_meio.x = 500*i 
	arvore_meio.y = 230
	grupo_meio:insert( arvore_meio )

end

for i=1,4 do 
	local chao_meio = display.newImageRect ("imagens/ground.png", 1028, 256)
	chao_meio.x = 240*i 
	chao_meio.y = 460
	grupo_meio:insert( chao_meio )
end


for i=0,10 do
	local arvore_jogo = display.newImageRect( "imagens/tree.png", 256, 256)
	arvore_jogo.x = 240*i
	arvore_jogo.y = 130
	grupo_jogo:insert( arvore_jogo )
	print(i)
end

for i=0, 4 do
	local chao_jogo = display.newImageRect ("imagens/ground.png", 1028, 256)
	chao_jogo.x = chao_jogo.width*i
	chao_jogo.y = 360 
	grupo_jogo:insert( chao_jogo )
end


local player = player_script.novo (grupo_meio, grupo_jogo, grupo_HUD)

local player_nome_texto = display.newText( {text="Nome: Mario", x=60, y=20, font=nil, size=28} )
grupo_HUD:insert( player_nome_texto )

local player_moedas_texto = display.newText( {text="Moedas: 100", x=60, y=40, font=nil, size=28} )
grupo_HUD:insert( player_moedas_texto )
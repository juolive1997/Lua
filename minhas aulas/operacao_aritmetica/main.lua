local vidas = 5
-- Operação de soma
vidas = vidas +1
print ("Vidas: ".. vidas) 

local pocao = 10
-- Operação de subtração
pocao = pocao -1
print ( "Poções: " .. pocao )
vidas = vidas + pocao
print ("Vidas + Poções: ".. vidas) 

local municao = 10
-- Operação de multiplicação
municao = municao * 2
print ("Munição: " .. municao )


local HP = 100
-- Operação de divisão
HP = HP/2
print ( "HP: " .. HP)


local Player = display.newImageRect("images/mario.png", 928/10, 1024/10)
Player.x = 320*0.5
Player.y = 480*0.5

print ("Player X" .. Player.x) 
print ("Player Y" .. Player.y) 

local function somar_x ()
Player.x = Player.x +1
print ("Player X: " .. Player.x) 
end

somar_x()

--Executa uma função com atraso.
--                     tempo, função, número de repetição.
--timer.performWithDelay( 100, somar_x, 10 )
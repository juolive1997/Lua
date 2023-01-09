local composer = require( "composer" )

local scene = composer.newScene()

local somRecordes

-- -----------------------------------------------------------------------------------
-- O código fora das funções de evento de cena abaixo será executado apenas UMA VEZ, a menos que
-- a cena é removida totalmente (não reciclada) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local json = require ("json") -- chama a biblioteca json dentro do lua. 
local pontosTable = {}
local filePath = system.pathForFile ("pontos.json", system.DocumentsDirectory) -- cria pasta no sistema 
-- que irá armazenar as 10 maiores pontuações.


local function carregaPontos ()

    audio.play( somRecordes )

        local file = io.open (filePath, "r") -- identifica se o arquivo .json existe. Abre apenas 
        --para leitura.
-- se o arquivo existe então,
        if file then
            local contents = file:read ("*a") -- inclui o arquivo dentro da variavel contents
            io.close (file ) -- fecha o arquivo
            pontosTable = json.decode (contents) -- inclui o arquivo dentro da tabela (transforma 
            -- os dados em tabela)
        end -- fecha a função if 
-- Se a tabela estiver vazia ou com valores nulos, então 
        if (pontosTable == nil or #pontosTable == 0 ) then
            pontosTable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0} -- cria sequencia de 10 zeros para aparecer 
            -- no lugar
            --pontosTable = { 10000, 7500, 5200, 4700, 3500, 3200, 1200, 1100, 800, 500 }
-- dos recordes. 
        end
end 

local function savePontos ()
    for i = #pontosTable, 11, -1 do -- seleciona todas as informações abaixo de 11 e 
        table.remove( pontosTable, i ) -- remove de dentro da tabela.
    end -- fecha a função for.

    local file = io.open (filePath, "w") -- abre o arquivo com possibilidade de editar e substituir.

    if file then 
        file:write (json.encode (pontosTable) ) -- salva a tabela atualizada dentro do arquivo .json
        io.close( file ) -- fecha o arquivo.
    end -- fecha o if

end -- fecha a função savePontos.

local function gotoMenu ()
    composer.gotoScene( "menu", {time=800, effect="crossFade"})
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    carregaPontos()
-- Organiza as pontuações em ordem decrescente.
    table.insert( pontosTable, composer.getVariable ( "finalScore") ) 
    composer.setVariable ("finalScore", 0)


    local function compare (a, b)
    return a > b
    end

table.sort (pontosTable, compare)

savePontos()

local bg = display.newImageRect(sceneGroup, "imagens/bg.png", 800, 1400)
bg.x = display.contentCenterX
bg.y = display.contentCenterY


local recordesHeader = display.newText( sceneGroup, "Recordes ", display.contentCenterX, 100, arial, 44 )

    for i = 1, 10 do
        if (pontosTable [i]) then 
            local yPos = 150 + (i * 56) -- espaçamento entre os recordes uniforme

local rankNum = display.newText (sceneGroup, i .. ")", display.contentCenterX-50, yPos, arial, 36)
    rankNum:setFillColor( 0.8 )
    rankNum.anchorX = 1 -- alinhado a direita

local thisScore = display.newText( sceneGroup, pontosTable[i], display.contentCenterX-30, yPos, arial, 36 )
    thisScore.anchorX = 0 -- alinhado a esquerda
        end
    end 
local botaoMenu = display.newText (sceneGroup, "Menu", display.contentCenterX, 810, arial, 44 )
    botaoMenu:setFillColor( 0.75, 0.78, 1 )
    botaoMenu:addEventListener( "tap", gotoMenu )

    somdeFundo = audio.loadStream("audio/Midnight-Crawlers_Looping.wav")
end

-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

       audio.play (somdeFundo, {channel=2, loops=-1})

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    audio.stop (2)
    composer.removeScene( "recordes" )
    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
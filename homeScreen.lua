local composer = require( "composer" )
 
local scene = composer.newScene()
local widget = require("widget")
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
function start( event )
    composer.gotoScene( "inputScreen", "crossFade",400)
end

-- create()
function scene:create( event )
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    display.setDefault( "background", 1, 1, 1 )  



    local cannon = display.newImage( "cannonball.png" )
    -- Position the image
    cannon:translate( display.contentCenterX, 100 )
    cannon:scale( .7, .7 )

    local title = display.newImage( "title.png" )
    -- Position the image
    title:translate( display.contentCenterX, 300 )
    title:scale( .35, .35 )

            -- Create the widget submit button
    startButton = widget.newButton(
        {
            id = "start",
            label = "START",
            shape = "roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 2,
            fillColor = { default={0,.7,0,1}, over={0,0.7,0,0.4} },
            labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            strokeColor = { default={0,0.9,0,1}, over={0,0.8,0,1} },
            strokeWidth = 2,
            onEvent = start
        }
    )

    startButton.x = display.contentCenterX
    startButton.y = 480

    sceneGroup:insert( cannon )
    sceneGroup:insert( title )
    sceneGroup:insert( startButton )
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        sceneGroup:removeSelf( )
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
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
local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
local chart = require( "chart" )

local x_cordinates = {}
local y_cordinates = {}

local x_normalized_cordinates = {}
local y_normalized_cordinates = {}

local function displayChart()
    local line = display.newLine( 0, 0, 0, 0 )
    -- star:append( 305,165, 243,216 )

    for k, v in ipairs(y_normalized_cordinates) do
        line:append( x_normalized_cordinates[k],y_normalized_cordinates[k] )
    end
    --print(y_normalized_cordinates[1])
    line:setStrokeColor( 0, 1, 0, 1 )
    line.strokeWidth = 3
end

local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
        local time = timeInputFunc()
        local angle = angleInputFunc()
        local velocity = velocityInputFunc()

        x_cordinates, y_cordinates = chart:calcProjectile(time, angle, velocity)
        x_normalized_cordinates, y_normalized_cordinates = chart:normalizingData(x_cordinates, y_cordinates)
        
        displayChart()
    end
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
    local chart = display.newLine( 150, 290, 150, 80 )
    chart:append( 150,290, 500, 290 )

    chart:setStrokeColor( 1, 0, 0, 1 )
    chart.strokeWidth = 3

    local widget = require( "widget" )

    -- Create the widget
    local button1 = widget.newButton(
        {
            left =-50,
            top = 270,
            id = "button1",
            label = "Create Chart",
            onEvent = handleButtonEvent
        }
    )

    -- Set default screen background color to blue
    display.setDefault( "background", 1, 1, 1 )
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        --angle input
        local angleInput = native.newTextField( 50, 150, 150, 36 )
        angleInput.inputType = "number"

        --init velocity input
        local velocityInput = native.newTextField( 50, 200, 150, 36 )
        velocityInput.inputType = "number"

        --time input
        local timeInput = native.newTextField( 50, 250, 150, 36 )
        timeInput.inputType = "number"

        function timeInputFunc()
            return timeInput.text
        end

        function velocityInputFunc()
            return velocityInput.text 
        end

        function angleInputFunc()
            return angleInput.text 
        end

        function test(event)
            print( "hi" )
        end
        local widget = require( "widget" )

        -- Create the widget
        local button2 = widget.newButton(
            {
                left =-50,
                top = 0,
                id = "button2",
                label = "Clean Chart",
                onEvent = test
            }
        )

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
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
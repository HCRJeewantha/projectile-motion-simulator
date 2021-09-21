local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
local chart = require( "chart" )

local x_cordinates = {}
local y_cordinates = {}
local range = 0
local time = 0
local max_height = 0

local x_normalized_cordinates = {}
local y_normalized_cordinates = {}
local line
local rangeText
local maxHeightText
local timeText

local function displayChart()
    line:append()
    for k, v in ipairs(y_normalized_cordinates) do
        line:append( x_normalized_cordinates[k],y_normalized_cordinates[k] )
    end
end

local function clear( event )
    composer.removeScene( "line" )
    print( "hi" )
end



local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
        local angle = angleInputFunc()
        local velocity = velocityInputFunc()

        x_cordinates, y_cordinates, time = chart:calcProjectile(angle, velocity)
        x_normalized_cordinates, y_normalized_cordinates, range, max_height = chart:normalizingData(x_cordinates, y_cordinates)
        rangeText.text = "range "..range
        maxHeightText.text = "max height "..max_height
        timeText.text = "air time "..time
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
 
    line = display.newLine( 0, 0, 0, 0 )
    line:setStrokeColor( 0, 1, 0, 1 )
    line.strokeWidth = 3

    sceneGroup:insert( line )

    rangeText = display.newText( "range 0", 70, 20, native.systemFont, 16 )
    rangeText:setFillColor( 1, 0, 0 )

    maxHeightText = display.newText( "max height 0", 70, 40, native.systemFont, 16 )
    maxHeightText:setFillColor( 1, 0, 0 )

    timeText = display.newText( "range 0", 70, 60, native.systemFont, 16 )
    timeText:setFillColor( 1, 0, 0 )

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

    -- Create the widget
    -- local button2 = widget.newButton(
    --     {
    --         left =-50,
    --         top = 20,
    --         id = "button1",
    --         label = "Clear Chart",
    --         onEvent = clear
    --     }
    -- )

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
       
        --init velocity input
        local velocityInput = native.newTextField( 50, 200, 150, 36 )

        function velocityInputFunc()
            return velocityInput.text 
        end

        function angleInputFunc()
            return angleInput.text 
        end

   

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
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
        rangeText.text = "Range: "..range.." m"
        maxHeightText.text = "Max height: "..max_height.." m"
        timeText.text = "Air time: "..time.." s"
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

    local chart = display.newLine(  40, 10, 40, 180 )
    chart:append(  300, 180 )
    chart:setStrokeColor( 1, 0, 0, 1 )
    chart.strokeWidth = 3

    rangeText = display.newText( "Range: 0 m", display.contentCenterX, 200, native.systemFont, 16 )
    rangeText:setFillColor( 1, 0, 0 )

    maxHeightText = display.newText( "Max height: 0 m", display.contentCenterX, 225, native.systemFont, 16 )
    maxHeightText:setFillColor( 1, 0, 0 )

    timeText = display.newText( "Air time: 0 s", display.contentCenterX, 250, native.systemFont, 16 )
    timeText:setFillColor( 1, 0, 0 )

    local widget = require( "widget" )

    -- Create the widget
    local button1 = widget.newButton(
        {
            id = "button1",
            label = "Create Chart",
            shape = "roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 2,
            fillColor = { default={0,1,0,1}, over={0,0.7,0,0.4} },
            strokeColor = { default={0,0.9,0,1}, over={0,0.8,0,1} },
            strokeWidth = 2,
            onEvent = handleButtonEvent
        }
    )
    button1.x = display.contentCenterX
    button1.y = 480

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
        angleInputText = display.newText( "Angle in degrees", display.contentCenterX, 300, native.systemFont, 16 )
        angleInputText:setFillColor( 0, .8, 0 )
        local angleInput = native.newTextField( display.contentCenterX, 340, 200, 36 )
       
        --init velocity input
        angleInputText = display.newText( "Velocity in m/s", display.contentCenterX, 380, native.systemFont, 16 )
        angleInputText:setFillColor( 0, .8, 0 )
        local velocityInput = native.newTextField( display.contentCenterX, 415, 200, 36 )

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
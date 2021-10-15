local composer = require( "composer" )
local scene = composer.newScene()

local display = require ("display")
local native = require("native")
local widget = require("widget")
local arrow
local velocityDisplayText
local angleDisplayText
local position_x
local position_y
local angleValue
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- Slider listener
local function sliderListenerAngle( event )
    -- print( "Slider at " .. event.value .. "%" )
    angleValue = event.value
    display.remove( angleDisplayText )
    angleDisplayText = nil
    angleDisplayText = display.newText( event.value.."°", 250, 300, native.systemFont, 16 )
    angleDisplayText:setFillColor( 0, .8, 0 )
    local xUser = tonumber(event.value)
    position_x = 120 * math.cos(math.rad(xUser)) + 80
    position_y = -120 * math.sin(math.rad(xUser)) + 190
    local function rockRect()
        transition.to( arrow, { rotation= -xUser, time=500, transition=easing.inOutCubic } )
    end
    rockRect()
end


-- Slider listener
local function sliderListenerVelocity( event )
    print( "Slider at " .. event.value .. "%" )
    display.remove( velocityDisplayText )
    velocityDisplayText = nil
    velocityDisplayText = display.newText( (event.value/20).." m/s", 250, 380, native.systemFont, 16 )
    velocityDisplayText:setFillColor( 0, .8, 0 )
    velocityValue = event.value/20
end

local function submitResults( event )
    local validation1 = true
    local validation2 = true
    local validation3 = true

    if (event.phase == "ended" or event.phase == "submitted") then

        print("Button was presses and released")

            
        if (angleValue == nil or angleValue == '') then
            native.showAlert("Error!","No empty fields allowed",{"OK"})
            validation1 = false
        else
            if (angleValue > 0 and angleValue < 90) then
                print ("angle Value: Valid")
            else
                print("angle Value: Invalid")
                native.showAlert("Error!","angle should be between 0 and 90",{"OK"})
                validation2 = false
            end
        end

        if (velocityValue == nil or velocityValue == '') then 
            native.showAlert("Error!","No empty fields allowed",{"OK"})
            validation3 = false
        else
            if (velocityValue>=0 and velocityValue<=10) then
                print ("velocity Value: Valid")
            else
                print("velocity Value: Invalid")
                native.showAlert("Error!","velocity should be between 0 and 10",{"OK"})
                validation2 = false
            end
        end

        if (validation1 == true and validation2 == true and validation3 == true) then
            customParams = {
                angle = angleValue,
                velocity = velocityValue
            }
            composer.gotoScene( "displayChart", { effect="crossFade", time=400, params=customParams } )
        else
            return
        end
    end
end

local function displayInterface()

    hedding = display.newText( "Projectile Motion Simulator", display.contentCenterX, 10, native.systemFont, 20 )
    hedding:setFillColor( 0, 0, .8 )

    --angle input
    angleInputText = display.newText( "Angle", 80, 300, native.systemFont, 16 )
    angleInputText:setFillColor( 0, .8, 0 )
    angleDisplayText = display.newText( "0°", 250, 300, native.systemFont, 16 )
    angleDisplayText:setFillColor( 0, .8, 0 )

    --init velocity input
    velocityInputText = display.newText( "Velocity", 80, 380, native.systemFont, 16 )
    velocityInputText:setFillColor( 0, .8, 0 )
    velocityDisplayText = display.newText( "0 m/s", 250, 380, native.systemFont, 16 )
    velocityDisplayText:setFillColor( 0, .8, 0 )

    -- Create the widget
    angleSlider = widget.newSlider(
        {
            x = display.contentCenterX,
            y = 340,
            width = 200,
            value = 1,  -- Start slider at 10% (optional)
            listener = sliderListenerAngle
        }
    )

        -- Create the widget
    velocitySlider = widget.newSlider(
        {
            x = display.contentCenterX,
            y = 410,
            width = 200,
            value = 1,  -- Start slider at 10% (optional)
            listener = sliderListenerVelocity
        }
    )
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    display.setDefault( "background", 1, 1, 1 )

end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    local params = event.params

    if ( phase == "will" ) then

        print("----Scene 01----")
        angleValue = 0
        velocityValue = 0
        displayInterface()

        local projectileObj = display.newCircle( 80, 190, 20 )
        projectileObj:setFillColor( 0.8, 0.8, 0.4, .8 )
        projectileObj.strokeWidth = 1
        projectileObj:setStrokeColor( 0, 0, 0 )

        graph = display.newLine(  40, 50, 40, 270 )
        graph:append(  300, 270, 300, 50, 40, 50 )
        graph:setStrokeColor( 0, 0, 0, .5 )
        graph.strokeWidth = 1.8

        local rect = display.newRect( 40, 215, 260, 10 )
        rect.anchorX = 0
        rect.anchorY = 0
        rect:setFillColor( .9, .5, 0 )

        local horizantal_line = display.newLine( 40, 190, 300, 190 )
        horizantal_line:setStrokeColor( 0, 0, 1, .5 )
        horizantal_line.strokeWidth = 1

        local vertical_line = display.newLine( 80, 50, 80, 270 )
        vertical_line:setStrokeColor( 0, 0, 1, .5 )
        vertical_line.strokeWidth = 1

        local gravity_force = display.newLine( 80, 190, 80, 260 )
        gravity_force:append(  90, 250, 80, 260, 70, 250 )
        gravity_force:setStrokeColor( 1, .5, 0.5, .7 )
        gravity_force.strokeWidth = 3

        gravityForceText = display.newText( "-0.03184 N", 130, 250, native.systemFont, 16 )
        gravityForceText:setFillColor( 0, .9, 0 )

        arrow = display.newImage( "arrow.png" )

        -- Position the image
        arrow:translate( 80, 190 )
        arrow:scale( 0.07, 0.04 )

        arrow.anchorX = 0
        arrow.anchorY = 0.5

        -- Create the widget submit button
        submitButton = widget.newButton(
            {
                id = "submit",
                label = "DISPLAY CHART",
                shape = "roundedRect",
                width = 200,
                height = 40,
                cornerRadius = 2,
                fillColor = { default={0,.7,0,1}, over={0,0.7,0,0.4} },
                labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
                strokeColor = { default={0,0.9,0,1}, over={0,0.8,0,1} },
                strokeWidth = 2,
                onEvent = submitResults
            }
        )
        submitButton.x = display.contentCenterX
        submitButton.y = 480

        -- sceneGroup:insert( hedding )
        sceneGroup:insert( projectileObj )
        sceneGroup:insert( arrow )
        sceneGroup:insert( rect )
        sceneGroup:insert( horizantal_line )
        sceneGroup:insert( vertical_line )
        sceneGroup:insert( gravity_force )

        sceneGroup:insert( submitButton )
        sceneGroup:insert( angleSlider )
        sceneGroup:insert( velocitySlider )
        sceneGroup:insert( graph )
        

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        angleSlider:removeSelf( )
        velocitySlider:removeSelf( )
        angleInputText:removeSelf( )
        velocityInputText:removeSelf( )
        arrow:removeSelf( )
        gravityForceText:removeSelf( )
        velocityDisplayText:removeSelf( )
        angleDisplayText:removeSelf( )
           
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then

        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    composer.removeScene()
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
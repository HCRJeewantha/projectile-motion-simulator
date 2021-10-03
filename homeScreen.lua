local composer = require( "composer" )
local scene = composer.newScene()

local display = require ("display")
local native = require("native")
local widget = require("widget")
local angleDirection 
local arrow
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
-- xValue TextBox Event
local function getAngle(event)
    display.remove( angleDirection )
    angleDirection = nil
    angleDirection = display.newLine( 80, 190, 250, 190 )
    angleDirection:setStrokeColor( 1, 0, 0, .5 )
    angleDirection.strokeWidth = 3

    if (event.phase  == "ended") then
        if (event.target.text == '' or event.target.text == nil) then
            native.showAlert("Error!","No empty fields allowed",{"OK"})
        else
            value = tonumber(event.target.text)
            if (value < 0 or value > 90) then
                native.showAlert("Error!","X Value should be between 0 and 90",{"OK"})
            else
                local xUser = tonumber(event.target.text)
                local function rockRect()
                    transition.to( arrow, { rotation= -xUser, time=500, transition=easing.inOutCubic } )
                end
                rockRect()
                local position_x = 170 * math.cos(math.rad(xUser)) + 80
                local position_y = -160 * math.sin(math.rad(xUser)) + 190

                local myCircle = display.newCircle( 80, 190, 20 )
                myCircle:setFillColor( 0, .8, 0, .5 )
                myCircle.strokeWidth = 2
                myCircle:setStrokeColor( 0, 0, 0 )

                gravityLine = display.newLine( 80, 190, 80, 250 )
                gravityLine:setStrokeColor( 0, 0, .8, .7 )
                gravityLine:append( 70, 250, 80, 260, 90, 250, 70, 250 )

                gravityLine.strokeWidth = 3


                angleDirection:append( 80, 190, position_x, position_y )

            end
        end
    end

end

local function displayInterface()

    hedding = display.newText( "Projectile Motion Simulator", display.contentCenterX, 10, native.systemFont, 20 )
    hedding:setFillColor( 0, 0, .8 )

    --angle input
    angleInputText = display.newText( "Angle in degrees", display.contentCenterX, 300, native.systemFont, 16 )
    angleInputText:setFillColor( 0, .8, 0 )
    angleInput = native.newTextField( display.contentCenterX, 340, 200, 36 )
           
    --init velocity input
    velocityInputText = display.newText( "Velocity in m/s", display.contentCenterX, 380, native.systemFont, 16 )
    velocityInputText:setFillColor( 0, .8, 0 )
    velocityInput = native.newTextField( display.contentCenterX, 415, 200, 36 )

    local function submitResults( event )
        local validation1 = true
        local validation2 = true
        local validation3 = true

        if (event.phase == "ended" or event.phase == "submitted") then

            print("Button was presses and released")
            -- Validation
            if (angleInput.text == nil or angleInput.text == '') then
                native.showAlert("Error!","No empty fields allowed",{"OK"})
                validation1 = false
            else
                angleValue = tonumber(angleInput.text)
                if (angleValue > 0 and angleValue < 90) then
                    print ("angle Value: Valid")
                else
                    print("angle Value: Invalid")
                    native.showAlert("Error!","angle should be between 0 and 90",{"OK"})
                    validation2 = false
                end
            end

            if (velocityInput.text == nil or velocityInput.text == '') then 
                native.showAlert("Error!","No empty fields allowed",{"OK"})
                validation3 = false
            else
                velocityValue = tonumber(velocityInput.text)
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

    -- Create the widget
    submitButton = widget.newButton(
        {
            id = "submit",
            label = "DISPLAY CHART",
            shape = "roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 2,
            fillColor = { default={0,1,0,1}, over={0,0.7,0,0.4} },
            strokeColor = { default={0,0.9,0,1}, over={0,0.8,0,1} },
            strokeWidth = 2,
            onEvent = submitResults
        }
    )
    submitButton.x = display.contentCenterX
    submitButton.y = 480

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
        displayInterface()

        local rect = display.newRect( 150, 100, 150, 10 )
        rect:setFillColor( 1, 0, 0 )
   

        arrow = display.newImage( "arrow.png" )
 
        -- Position the image
        arrow:translate( 100, 100 )
        arrow:scale( 0.08, 0.06 )

        arrow.anchorX = 0
        arrow.anchorY = 0.5
   


        angleInput:addEventListener("userInput",getAngle)
        sceneGroup:insert( hedding )
        sceneGroup:insert( submitButton )
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        angleInputText:removeSelf()
        velocityInputText:removeSelf()
        angleInput:removeSelf()
        velocityInput:removeSelf()

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
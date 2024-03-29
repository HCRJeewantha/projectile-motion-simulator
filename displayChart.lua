local composer = require( "composer" )
local scene = composer.newScene()
local chart = require( "Modules.functions" )
local display = require ("display")
local native = require("native")
local widget = require("widget")
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
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
local angle
local velocity
local hrLineGroup

 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local function displayChart()

    line = display.newLine( 0, 0, 0, 0 )
    line:setStrokeColor( 0, 0, 1, 1 )
    line.strokeWidth = 1.5

    graph = display.newLine(  40, 50, 40, 230 )
    graph:append(  300, 230, 300, 50, 40, 50 )
    graph:setStrokeColor( 0, 0, 0, .5 )
    graph.strokeWidth = 1.8

    for k, v in ipairs(y_normalized_cordinates) do
        line:append( x_normalized_cordinates[k],y_normalized_cordinates[k] )
    end

    fullGraph = display.newGroup()
    fullGraph:insert(graph)
    fullGraph:insert(line)
end

local function createChart(angle, velocity)
    x_normalized_cordinates, y_normalized_cordinates, range, max_height, time, y_max_cordinate, x_max_cordinate = chart:newChartData(angle, velocity)
    rangeText.text = "Range: "..range.." m"
    maxHeightText.text = "Max height: "..max_height.." m"
    timeText.text = "Air time: "..time.." s"

    horizantal_line = display.newLine(  40, y_max_cordinate, 300, y_max_cordinate )
    horizantal_line:setStrokeColor( 0, 0.7, 0.7, 1 )
    horizantal_line.strokeWidth = 1.3

    print( y_max_cordinate )
    displayChart()
end

local function back()
    composer.gotoScene( "inputScreen", "crossFade",400)
end

local function exit()
    os.exit()
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)


    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        angle = tonumber(event.params.angle)
        velocity = tonumber(event.params.velocity)

        angle = tonumber(event.params.angle)
        velocity = tonumber(event.params.velocity)

        rangeText = display.newText( "Range: 0 m", 40, 250, native.systemFont, 16 )
        rangeText:setFillColor( 0, .8, 0 )
        rangeText.anchorX = 0
        rangeText.anchorY = 0

        maxHeightText = display.newText( "Max height: 0 m", 40, 275, native.systemFont, 16 )
        maxHeightText:setFillColor( 0, .8, 0 )
        maxHeightText.anchorX = 0
        maxHeightText.anchorY = 0

        timeText = display.newText( "Air time: 0 s", 40, 300, native.systemFont, 16 )
        timeText:setFillColor( 0, .8, 0 )
        timeText.anchorX = 0
        timeText.anchorY = 0

        velocityText = display.newText( "Initial Velocity: "..velocity.." m/s", 40, 325, native.systemFont, 16 )
        velocityText:setFillColor( 0, .8, 0 )
        velocityText.anchorX = 0
        velocityText.anchorY = 0

        angleText = display.newText( "Projectile Angle: "..angle.."°", 40, 350, native.systemFont, 16 )
        angleText:setFillColor( 0, .8, 0 )
        angleText.anchorX = 0
        angleText.anchorY = 0

        backButton = widget.newButton(
            {
            id = "back",
            label = "BACK",
            shape = "roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 2,
            fillColor = { default={0,.7,0,1}, over={0,0.7,0,0.4} },
            labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            strokeColor = { default={0,0.9,0,1}, over={0,0.8,0,1} },
            strokeWidth = 2,
            onEvent = back,
            }
        )
        backButton.x = display.contentCenterX
        backButton.y = 420

        exitButton = widget.newButton(
            {
            id = "exit",
            label = "EXIT",
            shape = "roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 2,
            fillColor = { default={0.7,0,0,1}, over={.6,0,0,0.4} },
            strokeColor = { default={1,0,0,1}, over={1,0,0,1} },
            labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            strokeWidth = 2,
            onEvent = exit,
            }
        )
        exitButton.x = display.contentCenterX
        exitButton.y = 480
        
        createChart(angle, velocity)
        sceneGroup:insert( fullGraph )
        sceneGroup:insert( backButton )
        sceneGroup:insert( exitButton )
        sceneGroup:insert( horizantal_line )
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        rangeText:removeSelf( )
        maxHeightText:removeSelf( )
        timeText:removeSelf( )
        velocityText:removeSelf( )
        angleText:removeSelf( )
        line:removeSelf( )
        horizantal_line:removeSelf( )
        sceneGroup:removeSelf( )
    
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
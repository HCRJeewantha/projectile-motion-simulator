-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local mass = 0.14529
local area = 0.003184
local density_air = 1.275
local drag_co = 0.5
local gravity_force = -9.81 * mass
--inputs
-- local time = 0.70 --s



local delta_time = 0.01

local x_cordinates = {}
local y_cordinates = {}

--this function returns drag froce
function dragForceCalculate(init_velocity)
    drag_force = 0.5 * density_air * (math.pow( init_velocity, 2 )) * area * drag_co -- Fd = ½ ρ v2 D A
    return drag_force
end

--this function returns acceleration for x and y directions
function calcAcceleration(net_force)
    acceleration = net_force / mass -- a = f/m
    return acceleration
end

--this function calculate velocity for x and y directions
function calcVelocity(init_velocity ,acceleration, delta_time)
    velocity = init_velocity + (acceleration * delta_time) -- v = u + at
    return velocity
end

function calcPosition(init_velocity ,acceleration, delta_time)
    position = init_velocity * delta_time + 0.5 * acceleration * (math.pow(delta_time, 2)) -- s = ut + 1/2 at^2
    return position
end

local net_force_x
local net_force_y

local drag_force_x
local drag_force_y

local acceleration_x
local acceleration_y

local velocity_x
local velocity_y

local position_x = 0
local position_y = 0

function calcProjectile(time, angle, init_velocity)
    local init_velocity_x = init_velocity * math.cos(angle)
    local init_velocity_y = init_velocity * math.sin(angle)
    for i = 1, time/10, 1 do
    --while(position_y >= 0)
    -- do

        --X direction
        --calculate drag force
        drag_force_x = -dragForceCalculate(init_velocity_x)
        --print(drag_force_x)
        --calculate net force
        net_force_x = drag_force_x

        --calculate acceleration
        acceleration_x = calcAcceleration(net_force_x)

        --calculate velocity
        velocity_x = calcVelocity(init_velocity_x, acceleration_x, delta_time)

        --store x cordinates for create chart
        x_cordinates[i] = position_x

        --calculate position
        position_x =  calcPosition(init_velocity_x, acceleration_x, delta_time) + position_x

        --final velosity == initial velocity
        init_velocity_x = velocity_x


        --Y direction
        --calculate drag force
        drag_force_y = dragForceCalculate(init_velocity_y)

        --calculate net force
        net_force_y = drag_force_y + gravity_force

        --calculate acceleration
        acceleration_y = calcAcceleration(net_force_y)

        --calculate velocity
        velocity_y = calcVelocity(init_velocity_y, acceleration_y, delta_time)

        --store x cordinates for create chart
        y_cordinates[i] = position_y

        --calculate position
        position_y =  calcPosition(init_velocity_y, acceleration_y, delta_time) + position_y

        --final velosity == initial velocity
        init_velocity_y = velocity_y
    end
    return x_cordinates, y_cordinates
end

function findMinAndMax(table)
    local key_max, max = 1, table[1]
    local key_min, min = 1, table[1]

    for k, v in ipairs(table) do
        if table[k] > max then
            key_max, max = k, v
        end
        if table[k] < min then
            key_min, min = k, v
        end
    end

    return min, max
end

local x_normalized_cordinates = {}
local y_normalized_cordinates = {}

--this function will normalized the data
function normalizingData()
    
    --normalizing
    x_min, x_max = findMinAndMax(x_cordinates)
    y_min, y_max = findMinAndMax(y_cordinates)

    for k, v in ipairs(x_cordinates) do
        x_normalized_cordinates[k] = 150 + (v - x_min) / (x_max - x_min) * 350 --zi = (xi – min(x)) / (max(x) – min(x)) * 300
    end

    for k, v in ipairs(y_cordinates) do
        y_normalized_cordinates[k] = 290 - (v - y_min) / (y_max - y_min) * 180 --zi = (xi – min(x)) / (max(x) – min(x)) * 300
    end

    return 0
end

function displayChart()
    local line = display.newLine( 0, 0, 0, 0 )
    -- star:append( 305,165, 243,216 )

    for k, v in ipairs(y_normalized_cordinates) do
        line:append( x_normalized_cordinates[k],y_normalized_cordinates[k] )
    end
    line:setStrokeColor( 0, 1, 0, 1 )
    line.strokeWidth = 3
end

--angle input
local angleInput = native.newTextField( 50, 150, 150, 36 )
angleInput.inputType = "number"

--init velocity input
local velocityInput = native.newTextField( 50, 200, 150, 36 )
velocityInput.inputType = "number"

--time input
local timeInput = native.newTextField( 50, 250, 150, 36 )
timeInput.inputType = "number"

local widget = require( "widget" )
 
-- Function to handle button events
local function handleButtonEvent( event )
 
    if ( "ended" == event.phase ) then
        -- angle = angleInput.text
        calcProjectile(timeInput.text, angleInput.text, velocityInput.text)
        normalizingData()
        displayChart()
        print("done")
    end
end
 
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






local chart = display.newLine( 150, 290, 150, 80 )
chart:append( 150,290, 500, 290 )

chart:setStrokeColor( 1, 0, 0, 1 )
chart.strokeWidth = 3

-- Set default screen background color to blue
display.setDefault( "background", 1, 1, 1 )



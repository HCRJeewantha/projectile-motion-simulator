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

local angle = 42
local init_velocity = 4.46944

-- local init_velocity_x = init_velocity * math.cos(angle)
-- local init_velocity_y = init_velocity * math.sin(angle)

local init_velocity_x = 4.46944
local init_velocity_y = 0.0

local delta_time = 0.01

local x_cordinates = {}
local y_cordinates = {}

--this function returns drag froce
function dragForceCalculate(init_velocity)
	drag_force = 0.5 * density_air * (math.pow( init_velocity, 2 )) * area * drag_co -- Fd = ½ ρ v2 D A
	return drag_force
end

--drag force for X and Y directions
-- local drag_force_x = -dragForceCalculate(init_velocity_x)
-- local drag_force_y = dragForceCalculate(init_velocity_y)

--calculate net force for X and Y directions
-- local net_force_x = -dragForceCalculate(init_velocity_x)
-- local net_force_y = dragForceCalculate(init_velocity_y) + gravity_force

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

for i = 1, 12, 1 do

	--X direction
	--calculate drag force
	drag_force_x = -dragForceCalculate(init_velocity_x)

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




    print( "vel", y_cordinates[i])
end

-- Set default screen background color to blue
display.setDefault( "background", 1, 1, 1 )





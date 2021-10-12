module(..., package.seeall)  -- need this to make things visible


--this function will round the input into 5 decimal places
function round(num)
  local mult = 10^5
  return math.floor(num * mult + 0.5) / mult
end

--this function retuens X and Y values of velocity with the angle
function testCalcXandYVelocity()
	--calcXandYVelocity(init_velocity, angle)
	--TC1
	init_velocity_x, init_velocity_y = calcXandYVelocity(4, 60)
	assert_equal(round(init_velocity_x), 2)
	assert_equal(round(init_velocity_y), 3.46410)

	--TC2
	assert_equal(calcXandYVelocity(0, 60), "Inital velocity should be grater than 0")

	--TC3
	assert_equal(calcXandYVelocity(5, 0), "Angle should be in range 0 < angle 90")

	--TC4
	init_velocity_x, init_velocity_y = calcXandYVelocity(5, 1)
	assert_equal(round(init_velocity_x), 4.99924)
	assert_equal(round(init_velocity_y), 0.08726)

	--TC5
	init_velocity_x, init_velocity_y = calcXandYVelocity(5, 2)
	assert_equal(round(init_velocity_x), 4.99695)
	assert_equal(round(init_velocity_y), 0.17450)

	--TC6
	init_velocity_x, init_velocity_y = calcXandYVelocity(5, 88)
	assert_equal(round(init_velocity_x), 0.1745)
	assert_equal(round(init_velocity_y), 4.99695)

	--TC7
	init_velocity_x, init_velocity_y = calcXandYVelocity(5, 89)
	assert_equal(round(init_velocity_x), 0.08726)
	assert_equal(round(init_velocity_y), 4.99924)

	--TC8
	assert_equal(calcXandYVelocity(5, 90), "Angle should be in range 0 < angle 90")

	--TC9
	init_velocity_x, init_velocity_y = calcXandYVelocity(5, 60)
	assert_equal(round(init_velocity_x), 2.5)
	assert_equal(round(init_velocity_y), 4.33013)
end


-- this function returns drag froce
function testDragForceCalculate_TC10()
	--dragForceCalculate(init_velocity_x)
	drag_force = dragForceCalculate(4)
	assert_equal(drag_force, 0.0162384)
end

--this function returns acceleration for x and y directions
function testCalcAcceleration_TC11()
	--calcAcceleration(net_force)
	acceleration = calcAcceleration(4)
	assert_equal(round(acceleration), 27.53114)
end


--this function calculate velocity for x and y directions in the given time period
function testCalcVelocity_TC12()
	--calcVelocity(init_velocity ,acceleration, delta_time)
	velocity = calcVelocity(4, 5, 4)
	assert_equal(round(velocity), 24)
end


--this function calculate position for x and y direction
function testCalcPosition_TC13()
	--calcPosition(init_velocity ,acceleration, delta_time)
	position = calcPosition(4, 60, 4)
	assert_equal(round(position), 496)
end
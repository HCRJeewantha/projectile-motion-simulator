module(..., package.seeall)  -- need this to make things visible


--CalcXandYVelocity()
--assert_equal(calcXandYVelocity(velocity,angle), velocity_x, velocity_y)

function testCalcXandYVelocity_TC1()
	assert_equal(test(5, 60), 5, 6)
end

-- function testCalcXandYVelocity_TC2()
-- 	assert_equal(dragForceCalculate(2.5), 0.006343125)
-- end


require("bow")
require("target")

local bowHeight = 70

rec = display.newRect(450, 150, 5, 40)
myBow = bow:new(50, 150, bowHeight, 25, 20)

myBow.addTarget(rec)

-- implement the collision event
myBow.onCollision = function(ev)
	local hits = #ev
	if hits > 0 then
		-- reload the bow
		myBow.reload()
		
		-- draw the arrow at the target
		local arrow = display.newImage("Images/arrow.png", 0, 0)
		-- retrieving event's data
		arrow.x, arrow.y = ev[1].x, ev[1].y
		arrow.rotation = ev[1].angle
		
		-- set the scale
		arrow.xScale = bowHeight / arrow.height / 2
		arrow.yScale = bowHeight / arrow.height / 2
	end
end
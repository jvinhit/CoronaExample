-- local currX, currY
-- local newX, newY = 0,0

-- local hero = display.newCircle(10,10,3)

-- local function taparoo ( event )
--     currX = newX
--     currY = newY
--     newX = event.x
--     newY = event.y

-- transition.to(hero, {time = 2*(math.sqrt((currX-newX)^2 + (currY-newY)^2 )), x=newX, y = newY })
-- end



-- Runtime:addEventListener("tap", taparoo)

--The Dot
local dot 
--The Rectangle (could be an image)
local rect

--In case you need physics
local physics = require "physics"
physics.start()
physics.setGravity( 0, 0 )
physics.setDrawMode( "hybrid" )

local doTurn = function(event)
	rect.rotation = rect.rotation + 5
end

dot = display.newCircle(display.contentWidth/2,display.contentHeight/2,5)
dot:setFillColor(200,0,0)

rect = display.newRect(0,0,20,40)
physics.addBody(rect)

--Change the reference point to the botton center of your rect
-- rect:setReferencePoint(display.BottomCenterReferencePoint)
rect.anchorX = .5
rect.anchorY = .5
--Set the coords. of your rect
rect.y = dot.y
rect.x = dot.x

--Run the animation
Runtime:addEventListener( "enterFrame", doTurn )
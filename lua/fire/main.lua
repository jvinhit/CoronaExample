local physics = require("physics")
physics.start()
physics.setScale( 40 )
display.setStatusBar( display.HiddenStatusBar )

local background = display.newImage( "background.jpg", 0, 0, true )
background.x = display.contentWidth / 2
background.y = display.contentHeight / 2

local floor = display.newImage( "floor.png", 240, 300, true )
physics.addBody( floor, "static", { friction=0.5 } )

local crates = {}

for i = 1, 4 do
    for j = 1, 4 do
        crates[i] = display.newImage( "crate.png", 140 + (i*50), 220 - (j*50) )
        physics.addBody( crates[i], { density=0.2, friction=0.1, bounce=0.5 } )
    end
end

local function onLocalCollision( self, event )
    if ( event.phase == "began" and self.myName == "circle" ) then
        print("collision")
        local forcex = event.other.x-self.x
        local forcey = event.other.y-self.y-20
        if(forcex < 0) then
            forcex = 0-(80 + forcex)-12
        else
            forcex = 80 - forcex+12
        end
        event.other:applyForce( forcex, forcey, self.x, self.y )
    end
end

local function setBomb ( event )
    if(event.phase == "began") then
        local bomb = display.newImage( "bomb.png", event.x,event.y )
        physics.addBody( bomb, { density=0.2, friction=0.1, bounce=0.5 } )

        local circle = ""
        local explosion = ""
        local function blast( event )
            media.playEventSound( explosionSound )
            circle = display.newCircle( bomb.x, bomb.y, 80 )
            explosion = display.newImage( "explosion.png", bomb.x, bomb.y )
            bomb:removeSelf()
            circle:setFillColor(0,0,0,0)
            physics.addBody( circle, {isSensor = true} )
            circle.gravityScale = 0
            circle.myName = "circle"
            circle.collision = onLocalCollision
            circle:addEventListener( "collision", circle )
        end

        local function removeStuff( event )
            circle:removeSelf()
            explosion:removeSelf()
        end
        timer.performWithDelay(3000, blast )
        timer.performWithDelay(10000, removeStuff)
    end
end
background:addEventListener("touch",setBomb)
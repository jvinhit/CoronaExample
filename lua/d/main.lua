w = display.contentWidth
h = display.contentHeight
display.setStatusBar(display.HiddenStatusBar);
local physics = require "physics"
physics.start()
function dropHim()
 falling = true
 physics.setGravity( 0, 100)
 print("getting down")
end
function init(startWith, winScore, spawnPercenat, thisLevel)
 if thisLevel then
 level = thisLevel + 1
 else
 level = 1
 end
 ammountToStartWith = startWith or 10
 levelWinScore = winScore or 100
 spawnPercenatge = spawnPercenat or 10

 gravDown = 2
 physics.setGravity( 0, gravDown)

 sideGhost = display.newRect(10, 0, 10, 10)
 sideGhost:rotate( 45 )

 flyButtonLeft = display.newRect(w-20,0,20,h)
 physics.addBody(flyButtonLeft, { density = 1.0, friction = 1.0, bounce = 5.0 } )
 flyButtonLeft.bodyType = "static"

 flyButtonRight = display.newRect(0,0,20,h)
 physics.addBody(flyButtonRight, { density = 1.0, friction = 1.0, bounce = 5.0 } )
 flyButtonRight.bodyType = "static"

 shootButtonUP = display.newCircle(w/2,h,50)
 powerHolder = display.newRect(0,0, w, 30)
 powerHolder:setFillColor(0,0,0, 200)
 powerMeter = display.newRect(0+10,0+10, w-20, 30-20)
 powerMeter:setFillColor(255,240,30, 200)
 powerMeter.xScale = 0.001
 -- powerMeter:setReferencePoint(display.TopLeftReferencePoint)
powerMeter.anchorX = 0
powerMeter.anchorU = 0

 flyBoy = display.newRect(w/2 - 15/2, -100, 15, 15)
 flyBoy:setFillColor(63,175,255)
 physics.addBody(flyBoy, { density = 1.0, friction = 1.0, bounce = 1.0 } )
 flyBoy.linearDamping = 5
 flyBoy.AngularDamping = 100
 flyBoy:applyAngularImpulse(.1)

 topGhost = display.newRect(20, 0, 10, 10)
 topGhost:setFillColor(0,0,0,0)
 topGhost:rotate( 45 )
charge = 0.0
 power = 0.0
 reverse = false
 enoughPower = false
 falling = false
 putText = true
 print(level)
 flyBoy:addEventListener("tap", dropHim)
end
init()
function buildPower(ammountOfEnergy, chargeSize)
 addToCharge = chargeSize or .05
 oneEnergyUnit = .5 / levelWinScore
 power = power + oneEnergyUnit * ammountOfEnergy
 if power < 1 then
 powerMeter.xScale = power
 else
 enoughPower = true
 end
 if charge < 25 then
 charge = charge + addToCharge
 print(charge)
 end
end
function startNewLevel()
 init(ammountToStartWith + 1.5, levelWinScore, spawnPercenatge * 1.5, level)
end
function flyLeft(event)
 if reverse == false then
 flyBoy:applyForce( 5, 0, flyBoy.x, flyBoy.y )
 buildPower(1)
 elseif reverse == true then
 flyBoy:applyForce( -5, 0, flyBoy.x, flyBoy.y )
 buildPower(1)
 end
end
function flyRight(event)
 if reverse == false then
 flyBoy:applyForce( -5, 0, flyBoy.x, flyBoy.y )
 buildPower(1)
 elseif reverse == true then
 flyBoy:applyForce( 5, 0, flyBoy.x, flyBoy.y )
 buildPower(1)
 end
end
function shootUp(event)
 if reverse == false then
 flyBoy:applyLinearImpulse( 0, -1*charge, flyBoy.x, flyBoy.y )
 charge = 0.0
 elseif reverse == true then
 flyBoy:applyLinearImpulse( 0, charge, flyBoy.x, flyBoy.y )
 charge = 0.0
 end
end
function makeEnemyPartical(locationX, locationY)
 locX = locationX + 20 or math.random(w) + 20
 locY = locationY or h + 20
 local enemyParicalSize = math.random(10)
 local chargeParicalSize = enemyParicalSize + (math.random(10)+ 1)
 local enemyParticalSpeed = math.random(1000) * level
 local chargePartical = display.newCircle(locX, locY, chargeParicalSize)
 local enemyPartical = display.newCircle(locX, locY, enemyParicalSize)
enemyPartical:setFillColor(191,41,0)
 chargePartical:setFillColor(255,255,0,200)
 physics.addBody( enemyPartical, { density = -1.0, friction = 1.0, bounce = 1.0, radius = enemyParicalSize })
 physics.addBody( chargePartical, { density = -1.0, friction = 1.0, bounce = 1.0, radius = chargeParicalSize })
 chargePartical.isSensor = true
 enemyPartical.bodyType = "kinematic"
 chargePartical.bodyType = "kinematic"
 enemyPartical:setLinearVelocity( 0, enemyParticalSpeed * -.02 - 2 )
 chargePartical:setLinearVelocity( 0, enemyParticalSpeed * -.02 - 2 )

 function killMe(event)
 display.remove(event)
 print("killed it")
 if event.y > 0 then
 gravDown = gravDown * 2
 physics.setGravity( 0, gravDown)
 print(gravDown)
 else
 print("Grav not hit by hit")
 end
 end

 function chargeMeUP(event)
 if event.y > 0 then
 display.remove(event)
 print("charged it")
 buildPower(5, 5)
 end
 end
enemyPartical.collision = killMe
 enemyPartical:addEventListener( "collision", enemyPartical)

 chargePartical.collision = chargeMeUP
 chargePartical:addEventListener( "collision", chargePartical)

end
function generator(event)
 enemySpawn = math.random(1000)
 if enemySpawn < spawnPercenatge then
 print("spawning")
 local randX = math.random(w)- 40
 makeEnemyPartical(randX, randY)
 end
end
function startMap(ammountToStartWith)
local i = ammountToStartWith
 while i > 1 do
 local randX = math.random(w)
 local randY = math.random(h - 100) + 100
 makeEnemyPartical(randX, randY)
 i = i - 1
 print("i made one")
 end
end
function checkForWin()
 if flyBoy.y > h then
 if enoughPower == true then
 startNewLevel()
 putText = true
 elseif enoughPower == false then
 --print("You Loos")
 end
 end
end
i = 1
function followPlayer()
 topGhost.y = 20
 topGhost.x = flyBoy.x
 if flyBoy.y < 0 then
 topGhost:setFillColor(255,255,255,100)
 physics.setGravity( 0, gravDown * 10)
 else
 topGhost:setFillColor(255,255,255,0)
 if falling == false then
 physics.setGravity( 0, gravDown)
 end
 end
 if enoughPower == false then
 sideGhost.y = flyBoy.y
 sideGhost.x = 20
 sideGhost:setFillColor(255,255,255,100)
 else
 if putText == true then
 local myText = display.newText("", 0, 0, native.systemFont, 12)
 myText:setTextColor(255, 255, 255)
 myText.text = "Level" .. i
 myText.x = 50
 myText.y = sideGhost.y

 sideGhost.x = 20
 sideGhost:setFillColor(255,255,255,255)
 i = i + 1
 putText = false
 end
 end
end
function gameIsRunning(event)
 generator(event)
 checkForWin()
 followPlayer()
end

flyButtonLeft:addEventListener("touch", flyLeft)
flyButtonRight:addEventListener("touch", flyRight)
shootButtonUP:addEventListener("tap", shootUp)
Runtime:addEventListener( "enterFrame", gameIsRunning )
flyBoy.collision = chargeMeUP
flyBoy:addEventListener( "collision", flyBoy)
startMap(ammountToStartWith)
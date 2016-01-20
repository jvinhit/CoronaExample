
-- local circleeffect = display.newRe("c1.png",200,200)
-- circleeffect.x=200
-- circleeffect.y=200
-- circleeffect.xScale=.4
-- circleeffect.yScale=.4
-- circleeffect.alpha=.5


-- local circletohide = display.newImageRect("c2.png",100,100)
-- circletohide.x=200
-- circletohide.y=200
-- circletohide.xScale=.1
-- circletohide.yScale=.1

-- local mask = graphics.newMask( "circletohide.png" )
-- circleeffect:setMask( mask )

-- circleeffect.maskScaleX=1
-- circleeffect.maskScaleY=1

-- circletohide.alpha = 0
-- transition.to(circletohide, {time=2500, xScale=2, yScale=2,alpha=0})
-- transition.to(circleeffect, {time=500, alpha=.2})

-- local function followcirlemask(event)
-- print("circletohide.xScale",circletohide.xScale)
-- circleeffect.maskScaleX=circletohide.xScale
-- circleeffect.maskScaleY=circletohide.xScale
-- return circletohide.maskYscale, circletohide.maskXscale
-- end

-- Runtime:addEventListener("enterFrame",followcirlemask)



--------------------------------------------------------
--                  necessary                            ---
--------------------------------------------------------
local myGroupst = display.newGroup( ) --group star
local mathr = math.random
local refX = display.contentWidth*.5
local refY = display.contentHeight*.5
local numberofstar = 8

local BackgroundBack = display.newImageRect( "back02.png",360,768)
BackgroundBack.x = display.actualContentWidth*0.5
BackgroundBack.y = display.actualContentHeight*0.5
BackgroundBack.xScale = 1
BackgroundBack.yScale = 1

--------------------------------------------------------
--                  CIrcle who explode            ---
--------------------------------------------------------

local circleeffect = display.newImageRect("c1.png",200,200) --circle with color of explosion
circleeffect.x=refX
circleeffect.y=refY
circleeffect.xScale=.5
circleeffect.yScale=.5
circleeffect.alpha=.5


local circletohide = display.newImageRect("c2.png",100,100) --invisible circle
circletohide.x=refX
circletohide.y=refY
circletohide.xScale=.02
circletohide.yScale=.02

local circleannular = display.newImageRect("c3.png",100,100) --shock wave
circleannular.x=refX
circleannular.y=refY
circleannular.xScale=.02
circleannular.yScale=.02

local mask = graphics.newMask( "circletohide.png" ) --the mask
circleeffect:setMask( mask )

circleeffect.maskScaleX=1
circleeffect.maskScaleY=1

circletohide.alpha = 0
transition.to(circletohide, {time=2100,delay=120, xScale=3, yScale=3,alpha=0})
transition.to(circleeffect, {time=1000,delay=0, alpha=.3})
transition.to(circleannular, {time=1000,delay=0, xScale=1.5, yScale=1.5,alpha=0})

local function followcirlemask(event) --function to follow the circlehide and assing that on the mask
print("circletohide.xScale",circletohide.xScale)
circleeffect.maskScaleX=circletohide.xScale
circleeffect.maskScaleY=circletohide.xScale
return circletohide.maskYscale, circletohide.maskXscale
end

Runtime:addEventListener("enterFrame",followcirlemask)

--------------------------------------------------------
--                  star                                       ---
--------------------------------------------------------
local st = {}
for a= 1,numberofstar do
st[a] = display.newImageRect( "star.png",40,40 )
st[a].x = refX
st[a].y = refY
st[a].alpha = .5
st[a].xScale=mathr(5,10)*0.1
st[a].yScale = st[a].xScale
st[a].clic = true
end

for u=1, #st do
st[u].complx = mathr(-50,50)
st[u].comply = mathr(-50,50)

print(st[u].compl)
st[u].xend = refX+st[u].complx
st[u].yend = refY+st[u].comply
end

local arm = {}
for a= 1,#st do
arm[a] = display.newImageRect( "arm.png",20,20 )
arm[a].x = refX
arm[a].y = refY
arm[a].anchorY = 1
arm[a].alpha = 1
arm[a].xScale=.3
arm[a].yScale = .8
arm[a].angle = nil
arm[a].angleR = nil --radians
arm[a].clic = true
end--for

local function calculate(a)
distY = st[a].yend - refY
distX =  st[a].xend - refX
arm[a].angleR= math.atan2(distY, distX)
arm[a].angle=(arm[a].angleR * 180 / math.pi) -90 --convert radians to degree + perpendicular
--arm[a].hypo = math.sqrt(distX*distX+distY*distY)
print(refX, refY, distX, distY, arm[a].angle )
end--function

	--------------------------------------------------------
	--     transtion on star and arm              ---
	--------------------------------------------------------

for a=1,#st do
local function finishthetransition()
transition.to(st[a],{time=600,alpha =0,xScale=0, yScale=0, transition=easing.inElastic})
transition.to(arm[a],{time=600,alpha =0,})
end--function finishthe...

calculate(a)
--initiate the arm and st >>star
arm[a]:rotate( arm[a].angle )
arm[a].alpha = 1
arm[a].x, arm[a].y = st[a].xend, st[a].yend
st[a].alpha =.2

transition.to(st[a],{x=st[a].xend,y=st[a].yend,delay=0, time=120,alpha =.8, onComplete = finishthetransition})
transition.to(arm[a],{time=120,alpha =1,yScale=1.2,onComplete = finishthetransition})
end--for
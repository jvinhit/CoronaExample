local composer = require("composer")
local physics = require("physics")
physics.start()
physics.setGravity(0,25)
local force = 0.2
local maxForce = 130
local maxChim = 5
local maxHeo = 1

local scene = composer.newScene()

local function lengthOf(a,b)
    local width, height = b[1]-a[1], b[2]-a[2]
    return (width*width + height*height)^0.5
end

local function extrudeToLen( origin, point, len )
    local length = lengthOf( origin, point )
    local len = len
    local factor = len / length
    local x, y = (point[1] - origin[1]) * factor, (point[2] - origin[2]) * factor
    local pt = {x + origin[1], y + origin[2]}
    return pt
end

local function taoDayNa(obj1, obj2)
    local obj
    obj  = display.newLine( obj1.x, obj1.y, obj2.x, obj2.y)
    obj.strokeWidth = 6
    obj:setStrokeColor(1,0,0)
    return obj
end
local touchChim
function touchChim(e)
    local group = scene.view
    local t = e.target
    local phase = e.phase
    if phase == "began" and t.id == group.idChim  then
        display.getCurrentStage():setFocus(t, e.id)
        t.isF = true
        t.xStart = e.x - t.x
        t.yStart = e.y - t.y
    elseif t.isF then
        if phase == "moved" then
            if lengthOf({(group.na1.x+group.na2.x)*0.5, (group.na1.y+group.na2.y)*0.5},{e.x - t.xStart, e.y - t.yStart}) <= maxForce then
                t.x = e.x - t.xStart
                t.y = e.y - t.yStart
            else
               local c = extrudeToLen({(group.na1.x+group.na2.x)*0.5, (group.na1.y+group.na2.y)*0.5},{e.x - t.xStart, e.y - t.yStart},maxForce)
               t.x = c[1]
               t.y = c[2]
            end


            display.remove(group.dayna1)
            group.dayna1 = nil
            display.remove(group.dayna2)
            group.dayna2 = nil
            group.dayna1  = taoDayNa(group.na1, t)
            group:insert(group.dayna1)
            group.dayna2  = taoDayNa(group.na2, t)
            group:insert(group.dayna2)


        else
            t:removeEventListener("touch", touchChim)
             t.bodyType = "dynamic"
             local xf, yf = -(t.x - e.xStart)*force, -(t.y - e.yStart)*force
             t:applyForce(xf, yf, t.x, t.y)

             display.remove(group.dayna1)
             group.dayna1 = nil
             display.remove(group.dayna2)
             group.dayna2 = nil
             group.dayna1  = taoDayNa(group.na1, {x = (group.na1.x+group.na2.x)*0.5, y = (group.na1.y+group.na2.y)*0.5})
             group:insert(group.dayna1)
             group.dayna2  = taoDayNa(group.na2, {x = (group.na1.x+group.na2.x)*0.5, y = (group.na1.y+group.na2.y)*0.5})
             group:insert(group.dayna2)

             group.idChim = group.idChim + 1
             if maxChim <  group.idChim then
                print("test Win")
             else

                 transition.to(group.chim[group.idChim],{time = 300, x = group.xMid, y = group.yMid})
             end


            display.getCurrentStage():setFocus(t, nil)
            t.isF = false
        end
    end
    return true
end

function scene:create(event)
    local group = self.view
    group.na1  = display.newCircle(group, 100, 280, 10)
    group.na2  = display.newCircle(group, 230, 380, 10)
    group.xMid, group.yMid =   (group.na1.x+group.na2.x)*0.5, (group.na1.y+group.na2.y)*0.5


    local i = 1
    group.chim = {}
    for i = 1, maxChim do
        group.chim[i]  = display.newCircle(group, i*60, 450, 20)
        group.chim[i].id = i
        group.chim[i]:addEventListener("touch", touchChim)
        group.chim[i]:setFillColor(1,0,1)
        physics.addBody(group.chim[i],"static",{radius = 25})
    end

    group.dayna1  = taoDayNa(group.na1, { x = group.xMid,  y = group.yMid})
    group:insert(group.dayna1)

    group.dayna2  = taoDayNa(group.na2, { x = group.xMid, y = group.yMid})
    group:insert(group.dayna2)


    group.limit = display.newCircle(group, group.xMid, group.yMid, maxForce)
    group.limit.alpha = 0.3
    group.idChim = 1



    group.heo = {}
    for i = 1, maxHeo do
        group.heo[i]  = display.newCircle(group, 0, 0, 40)
        group.heo[i].name = "heo"
        group.heo[i].x = 600
        group.heo[i].y = 300
        group.heo[i]:setFillColor(0,0,1)
        physics.addBody(group.heo[i],"dynamic",{radius = 40})
    end


    local vat = display.newRect(group,0,0,200, 200)
    vat.x = 600
    vat.y = 400
    physics.addBody(vat,"static")


    group.bg = display.newRect(group,400,490,800, 40)
    physics.addBody(group.bg,"static")
end

function scene:show(event)
    local group = self.view
    local phase = event.phase

    if phase == "will" then

    elseif phase == "did" then
        transition.to(group.chim[group.idChim],{time = 300, x = group.xMid, y = group.yMid})
    end
end


function scene:hide(event)
    local group = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then

    end
end

function scene:destroy(event)
    local group = self.view
end



scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
return scene
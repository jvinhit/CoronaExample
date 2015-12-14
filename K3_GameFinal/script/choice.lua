local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

local tapLevel, touchBg
function tapLevel(e)
    print("choice Level"..e.target.id)
    classControl.show()
    composer.gotoScene("script.level.level"..1)
end
function touchBg(e)
    local t = e.target
    local group = scene.view
    local phase = e.phase
    if phase == "began" then
        display.getCurrentStage():setFocus(t, e.id)
        t.isF = true
        group.gChoice.xStart = e.x - group.gChoice.x
    elseif t.isF then
        if phase == "moved" then
            group.gChoice.x = e.x - group.gChoice.xStart
        else
            if group.gChoice.x > 0 then
                group.gChoice.x = 0
            elseif group.gChoice.x < -(global.maxCat-1)*800   then
                group.gChoice.x = -(global.maxCat-1)*800
            end
            display.getCurrentStage():setFocus(t, nil)
            t.isF = false
        end
    end
    return true
end
function scene:create(event)
    local group = self.view
    group.gChoice = display.newGroup()
    group:insert(group.gChoice)
    group.title = display.newText(group,"Choice Level",400,50,nil, 70)
    group.gCat = {}
    local n,m =0,0
    for i = 1, global.maxCat do
        group.gCat[i] = display.newGroup()
        group.gChoice:insert(group.gCat[i])
        group.gCat[i].arr = {}
        n,m =0,0
        group.gCat[i].bg = display.newRect(group.gCat[i],0,0,800, 400)
        group.gCat[i].bg.x = 400
        group.gCat[i].bg.y = 480 - group.gCat[i].bg.contentHeight*0.5
        group.gCat[i].bg.alpha = 0.01
        group.gCat[i].bg:addEventListener("touch", touchBg)

        for j = 1, global.levInCat do
            n = n+1
            group.gCat[i].arr[j] = display.newText(j,0,0,nil, 30)
            group.gCat[i].arr[j].id = (i-1)*15 + j
            group.gCat[i].arr[j].x = n*130 + 10
            group.gCat[i].arr[j].y = m*130 + 150
            group.gCat[i]:insert(group.gCat[i].arr[j])
            group.gCat[i].arr[j]:addEventListener("tap", tapLevel)
            if n== 5 then
                n= 0; m= m+1
            end
        end
        group.gCat[i].x = (i-1)*800
    end


    group.back = widget.newButton{
        width = 100,                        --width of the image file(s)
        height = 40,                       --height of the image file(s)
        --defaultFile = "buttonDefault.png",  --the "default" image file
        --overFile = "buttonOver.png",        --the "over" image file
        label = "Back",
        font  =  native.systemFont,
        fontSize = 30,
        onRelease= function()
            composer    .gotoScene("script.menu")
        end,
    }
    group.back.x = 100
    group.back.y = 50
    group:insert(group.back)
end

function scene:show(event)
    local group = self.view
    local phase = event.phase

    if phase == "will" then
        classControl.hide()
    elseif phase == "did" then
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
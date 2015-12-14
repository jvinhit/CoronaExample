local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

function scene:create(event)
    local group = self.view
    group.sound = display.newText(group,"Sound: ON",0,0,nil, 30)
    group.sound.x = 700
    group.sound.y = 40
    group.sound:addEventListener("tap", function()
        if global.isSound then
            global.isSound = false
            group.sound.text = "Sound: Off"
        else
            global.isSound = true
            group.sound.text = "Sound: On"
        end
    end)

    group.play = widget.newButton{
       width = 100,                        --width of the image file(s)
       height = 40,                       --height of the image file(s)
       --defaultFile = "buttonDefault.png",  --the "default" image file
       --overFile = "buttonOver.png",        --the "over" image file
       label = "Play",
       font  =  native.systemFont,
       fontSize = 60,
       onRelease= function()
        composer.gotoScene("script.choice")
       end,
    }
    group.play.x = 400
    group.play.y = 240
    group:insert(group.play)
end

function scene:show(event)
    local group = self.view
    local phase = event.phase

    if phase == "will" then
        classControl.hide()
        if global.isSound then
            group.sound.text = "Sound: On"
        else
            group.sound.text = "Sound: Off"
        end
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
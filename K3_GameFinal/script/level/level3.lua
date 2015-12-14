local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local group = self.view
    group.load = display.newText(group,"Loading...",400,240,nil, 50)
end

function scene:show(event)
    local group = self.view
    local phase = event.phase

    if phase == "will" then

    elseif phase == "did" then
        global.timerId[#global.timerId+1] = timer.performWithDelay(100, function()
            --Load data here
            global.timerId[#global.timerId+1] = timer.performWithDelay(100, function()
                composer.gotoScene("script.menu")
            end, 1)
        end, 1)
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
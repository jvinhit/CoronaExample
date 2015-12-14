print("loading")
local composer = require("composer")
local scene = composer.newScene()

--========================================================================
--khai bao bien toan cuc
--========================================================================
w = display.contentWidth
h = display.contentHeight

function scene:create(event)
    local g = self.view
    g.txt = display.newText("LOADING...",0,0,nil,50)
    g.txt.x = w/2
    g.txt.y = h/2
    g:insert(g.txt)
    g.txt.font = native.systemFont        
end

function scene:show(event)
    local g = self.view
    local phase = event.phase
    if phase == "will" then
    elseif phase == "did" then
        timer.performWithDelay(50,function()
        --load data
            timer.performWithDelay(200,function()
                composer.gotoScene("script.menu")
            end)
        end)
    end
end

function scene:hide(event)
    local g = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
    end
end

function scene:destroy(event)
    local g = self.view

end

scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)
return scene
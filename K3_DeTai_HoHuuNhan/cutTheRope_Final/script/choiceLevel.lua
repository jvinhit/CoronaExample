print("choiceLevel")
local composer = require("composer")
local scene = composer.newScene()
local widget = require( "widget" )
local physics = require("physics")
physics.start()

local bt = {}

function scene:create(event)
    print("create choice")
    local g = self.view


end

function scene:show(event)
    local g = self.view
    local phase = event.phase

    if phase == "will" then
        rope = {}
        steel[1].alpha = 1
        steel[2].alpha = 1
        steel[3].alpha = 1
        steel[4].alpha = 1
        ball.red.alpha = 1
        ball.red2.alpha = 1
        ball.blue.alpha = 1
        rec.left.alpha = 1
        rec.right.alpha = 1
    elseif phase == "did" then
        print("show choice")
        g:insert(btMenu)
        g:insert(bg)
        g:insert(sound)

        bt[1] = widget.newButton{
            label = "1",
            labelColor = { default={1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fontSize = 150,
            font = native.systemFont ,

            onRelease = function()

                composer.gotoScene("script.level1")

            end
        }
        bt[1].x = w/2 - 200
        bt[1].y = h/2
        g:insert(bt[1])

        bt[2] = widget.newButton{
            label = "2",
            labelColor = { default={1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fontSize = 150,
            font = native.systemFont,
            onRelease = function()
                if choice >= 2 then

                    composer.gotoScene("script.level2")
                end
            end
        }
        bt[2].x = w/2
        bt[2].y = h/2
        g:insert(bt[2])

        bt[3] = widget.newButton{
            label = "3",
            labelColor = { default={1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fontSize = 150,
            font = native.systemFont ,
            onRelease = function()
                if choice >= 3 then
                    composer.gotoScene("script.level3")

                end
            end
        }
        bt[3].x = w/2 + 200
        bt[3].y = h/2
        g:insert(bt[3])

        if choice == 1 then
            bt[1].alpha = 1
            bt[2].alpha = 0.5
            bt[3].alpha = 0.5
        elseif choice == 2 then
            bt[1].alpha = 1
            bt[2].alpha = 1
            bt[3].alpha = 0.5
        elseif choice >= 3 then
            bt[1].alpha = 1
            bt[2].alpha = 1
            bt[3].alpha = 1
        end
    end
end

function scene:hide(event)
    local g = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
        print("hide choice")
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
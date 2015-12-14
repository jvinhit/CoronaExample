print("menu")
local composer = require("composer")
local widget = require("widget")
local physics = require("physics")
physics.start()
local scene = composer.newScene()

--===================================================================================
--khai bao bien toan cuc
isCheck = false
count = 0
creditsView = {}
txt = {}
choice = 1
bg = {}
rec = {}
steel = {}
ball = {}
rope = {}
line = {}
btRetry = {}
btMenu = {}
cir = {}


target1 = display.newGroup()
target2 = display.newGroup()
lines = display.newGroup()

--bien am thanh
sound = {}
play = {}
play1 = {}

--===================================================================================

--===================================================================================
--khai bao ham toan cuc
fplay = {}
fgoChoice = {}
ftapSound = {}
--===================================================================================


function scene:create(event)
    print("create menu")
    local g = self.view

    txt = display.newText(" ",w/2,25,native.systemFont,50)
    txt.alpha = 0.5
    --txtRetry = display.newText("Retry",w - 80,25,native.systemFont,50)
    --txtMenu = display.newText("Menu",w-80,75,native.systemFont,50)


    bg = display.newImage("image/bg.png",w/2,h/2)

    --am thanh nen
    play = audio.loadSound("audio/Smooth_Session_part01.mp3")
    play1 = audio.play(play,{channel = 1,loops = -1})

    --cac doi tuong chinh
    ball.red = display.newImage("image/ball_red.png")
    ball.red2 = display.newImage("image/ball_red.png")
    ball.blue = display.newImage("image/ball_blue.png")
    --steel = display.newImage("image/steel.png")
    steel[1] = display.newImage("image/steel.png")
    steel[2] = display.newImage("image/steel.png")
    steel[3] = display.newImage("image/steel.png")
    steel[4] = display.newImage("image/steel.png")

    rec.bottom = display.newImage("image/rec_bottom1.png")
    rec.bottom.x = w/2
    rec.bottom.y = h - 10

    rec.left = display.newImage("image/rec_left_right1.png")
    rec.left.x = 0
    rec.left.y = h/2

    rec.right = display.newImage("image/rec_left_right1.png")
    rec.right.x = w
    rec.right.y = h/2
    function fplay(event)
        composer.gotoScene("script.choiceLevel")
    end

    function fgoChoice()
        count = 0
        isCheck = false
        physics.stop()
        composer.gotoScene("script.choiceLevel")
        physics.start()
    end

    --================================
    --bat tat am thanh nen
    function ftapSound(event)
        if sound.name  == "sound" then
            audio.play(audio.loadSound("audio/button_press.mp3"),{loops = 0})
            display.remove(sound)
            print("s")
            sound = display.newImage("image/speaker.png")
            sound.name = "speaker"
            sound.x = 50
            sound.y = 30
            audio.stop(play1)



        elseif sound.name == "speaker" then
            audio.play(audio.loadSound("audio/button_press.mp3"),{channel = 2,loops = 0})
            display.remove(sound)
            print("speaker")
            sound = display.newImage("image/sound.png")
            sound.name = "sound"
            sound.x = 50
            sound.y = 30
            audio.play(play,{channel = 1,loops = -1})
        end
        sound:addEventListener("tap",ftapSound)
    end
    --tao nut am thanh
    sound = display.newImage("image/sound.png")
    sound.name = "sound"
    sound.x = 50
    sound.y = 30
    sound:addEventListener("tap",ftapSound)

    --================================

    --================================
    --cai dat cac hop chua qua bong
    function setTarget1(dx,dy)
        rec.tar1 = display.newRect(dx-52.5,dy-30,15,60)
        rec.tar2 = display.newRect(dx+52.5,dy-30,15,60)
        rec.tar3 = display.newRect(dx,dy,120,15)
        rec.tar_1 = display.newRect(dx-45,dy-30,2,55)
        rec.tar_2 = display.newRect(dx+45,dy-30,2,55)
        rec.tar_3 = display.newRect(dx,dy-8,100,2)
        rec.tar_1.alpha = 0
        rec.tar_2.alpha = 0
        rec.tar_3.name = "tar_red"
        rec.tar_3.alpha = 0
        rec.tar1:setFillColor(1,0,0)
        rec.tar2:setFillColor(1,0,0)
        rec.tar3:setFillColor(1,0,0)
        target1:insert(rec.tar1)
        target1:insert(rec.tar2)
        target1:insert(rec.tar3)
        target1:insert(rec.tar_1)
        target1:insert(rec.tar_2)
        target1:insert(rec.tar_3)
        physics.addBody(rec.tar1,"static",{friction =1,bounce = 0.1,density = 1})
        physics.addBody(rec.tar2,"static",{friction =1,bounce = 0.1,density = 1})
        physics.addBody(rec.tar3,"static",{friction =1,bounce = 0.1,density = 1})
        physics.addBody(rec.tar_1,"static",{friction =1,bounce = 0.1,density = 1})
        physics.addBody(rec.tar_2,"static",{friction =1,bounce = 0.1,density = 1})
        physics.addBody(rec.tar_3,"static",{friction =1,bounce = 0.1,density = 1})

    end
    function setTarget2(dx,dy)
        rec.tar4 = display.newRect(dx-52.5,dy-30,15,60)
        rec.tar5 = display.newRect(dx+52.5,dy-30,15,60)
        rec.tar6 = display.newRect(dx,dy,120,15)
        rec.tar_4 = display.newRect(dx-45,dy-30,2,55)
        rec.tar_5 = display.newRect(dx+45,dy-30,2,55)
        rec.tar_6 = display.newRect(dx,dy-8,100,2)
        rec.tar_4.alpha = 0
        rec.tar_5.alpha = 0
        rec.tar_6.name = "tar_blue"
        rec.tar_6.alpha = 0
        rec.tar4:setFillColor(0,0,1)
        rec.tar5:setFillColor(0,0,1)
        rec.tar6:setFillColor(0,0,1)
        target2:insert(rec.tar4)
        target2:insert(rec.tar5)
        target2:insert(rec.tar6)
        target2:insert(rec.tar_4)
        target2:insert(rec.tar_5)
        target2:insert(rec.tar_6)
        physics.addBody(rec.tar4,"static",{friction =1,bounce = 0.1,density = 1})
        physics.addBody(rec.tar5,"static",{friction =1,bounce = 0.1,density = 1})
        physics.addBody(rec.tar6,"static",{friction =1,bounce = 0.1,density = 1})
        physics.addBody(rec.tar_4,"static",{friction =1,bounce = 0.1,density = 1})
        physics.addBody(rec.tar_5,"static",{friction =1,bounce = 0.1,density = 1})
        physics.addBody(rec.tar_6,"static",{friction =1,bounce = 0.1,density = 1})

    end
    --================================



end

function scene:show(event)
    local g = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
        print("show menu")
        isCheck = false
        count = 0
        --g:insert(txtRetry)
        -- g:insert(txtMenu)
        g:insert(txt)
        g:insert(ball.red)
        g:insert(ball.red2)
        g:insert(ball.blue)
        g:insert(rec.bottom)
        g:insert(rec.left)
        g:insert(rec.right)
        g:insert(steel[1])
        g:insert(steel[2])
        g:insert(steel[3])
        g:insert(steel[4])

        --button Menu
        btMenu = widget.newButton{
            --width = 128,
            --height = 128,
            --defaultFile = "image/play1.png",
            --overFile = "image/play.png",
            label = "Level",
            font = native.systemFont,
            fontSize = 50,
            labelColor = { default={1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            onPress = function()
                audio.play(audio.loadSound("audio/button_press.mp3"),{loops = 0})
            end,
            onRelease = function()
                physics.stop()
                composer.gotoScene("script.choiceLevel")
                physics.start()
            end
        }
        btMenu.x = w - 80
        btMenu.y = 75
        g:insert(btMenu)


        g:insert(bg)
        g:insert(sound)
        --tao button play
        g.play = widget.newButton {

            --width = 128,
            --height = 128,
            --defaultFile = "image/play1.png",
            --overFile = "image/play.png",
            label = "Play",
            font = native.systemFont,
            fontSize = 150,
            labelColor = { default={1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            onPress = function()
                audio.play(audio.loadSound("audio/button_press.mp3"),{loops = 0})
            end,
            onRelease = function()
                timer.performWithDelay(50,function()
                --load data

                    timer.performWithDelay(100,function()
                        composer.gotoScene("script.choiceLevel")
                    end)
                end)
            end
        }
        g:insert(g.play)
        g.play.x = w/2
        g.play.y = h/2 - 100

        --tao button credits
        g.credits = widget.newButton {
            --defaultFile = "buttonDefault.png",
            --overFile = "buttonOver.png",
            label = "Credits",
            font = native.systemFont,
            fontSize = 80,
            labelColor = { default={1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            --onPress = function() end,
            onRelease = function()
                local function hideCredits(event)
                    g.play.alpha = 1
                    g.credits.alpha = 1
                    transition.to(creditsView,{time=300,y=display.contentHeight + creditsView.height, onComplete = function()
                        creditsView:removeEventListener("tap",hideCredits)
                        display.remove(creditsView)
                        creditsView = nil
                    end})
                end

                local function showCredits(event)
                    g.play.alpha = 0
                    g.credits.alpha = 0
                    creditsView = display.newText("   Products by\nHO HUU NHAN",w/2,500,nil,80)
                    transition.to(creditsView,{time=300, x = w/2,y=h/2, onComplete = function()
                        creditsView:addEventListener("tap",hideCredits)
                    end})
                end
                showCredits()
            end
        }
        g:insert(g.credits)
        g.credits.x = w/2
        g.credits.y = h/2 + 100

        steel[1].alpha = 0
        steel[2].alpha = 0
        steel[3].alpha = 0
        steel[4].alpha = 0
        ball.red.alpha = 0
        ball.red2.alpha = 0
        ball.blue.alpha = 0
        rec.left.alpha = 0
        rec.right.alpha = 0
    end
end

function scene:hide(event)
    local g = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
        print("hide menu")

        --display.remove(btPlay)
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
print("level1")
local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")
local widget = require ("widget")
physics.start()
--physics.setDrawMode("hybrid")

local timer1
local timer2
gRopes1 = display.newGroup()
local oldx, oldy = 0,0
---=============================================================================================
--cac ham dung trong level 1
---=============================================================================================

--================================
--ham cai dat thanh rope
local function setRope()
    local dx = h/2+40
    local dy = 0
    local j = 0
    for i=1,7 do
        rope[i] =  display.newImage("image/rect_stone_small.png",dx  , (dy)+i*10)
        rope[i].name = "rope"
        rope[i].num = i
        physics.addBody(rope[i],"dynamic",{frition = 0.1,bounce= 0.1,density = 20})
        gRopes1:insert(rope[i])

        if i == 1 then
            rope[i].bodyType = "static"
        end
        if(i == 2) then
            --lien ket rope1 voi rope2
            physics.newJoint('pivot', rope[1], rope[i], rope[1].x, rope[1].y)
        end

        if(i > 2) then
            --lien ket rope sau no voi rope truoc no
            physics.newJoint('pivot', rope[i-1], rope[i], rope[1].x, rope[i].y)
        end

        if(i == 7) then
            --lien ket rope cuoi cung voi qua bi sat
            physics.newJoint('pivot', rope[i], steel[1], steel[1].x, steel[1].y )
        end
    end
end
--================================

--================================
--xu ly su kien khi duong thang va soi day va cham
local function ropeCollision(e)
    print(e.other.name,e.other.num)
    if e.other.name == "rope" then
        local num = e.other.num
        local play = audio.loadSound("audio/rope_swish.mp3")
        audio.play(play,{loops = 0})
        for i=num,7 do
            display.remove(rope[i])
        end
        isCheck = true
    end
end
--================================

--================================
--tao mot duong thang khi ve
local function drawLine(e)
    local dx,dy = e.x,e.y
    local dx1 = 0
    local dy1 = 0
    if(e.phase == 'began') then
        oldx  = e.x
        oldy = e.y
    elseif(e.phase == 'moved') then
        line = display.newLine(oldx, oldy,e.x,e.y)
        oldx = e.x
        oldy = e.y
        line.strokeWidth = 5
        physics.addBody(line, 'static')
        line.isSensor = true
        line:addEventListener("collision", ropeCollision)
        lines:insert(line)
    elseif(e.phase == 'ended') then
        display.remove(lines)
        lines = nil
        lines = display.newGroup()
    end
end
--================================

--================================
--xu ly su kien khi va cham
local function onCollTargetRed(self,event)
    print(event.other.name)
    if event.other.name == "red" then
        --bat am thanh khi va cham dung muc tieu
        local play = audio.loadSound("audio/count_win.mp3")
        audio.play(play,{loops = 0})
        --tang bien dem
        count = count + 1
        --remove su kien cua chinh no
        rec.tar_3:removeEventListener("collision",rec.tar_3)
    end
    print(count)
end
local function onCollTargetBlue(self,event)
    print(event.other.name)
    if event.other.name == "blue" then
        local play = audio.loadSound("audio/count_win.mp3")
        audio.play(play,{loops = 0})
        count = count + 1
        rec.tar_6:removeEventListener("collision",rec.tar_6)
    end
    print(count)
end
--================================

--================================
--kiem tra dieu kien khi qua man
local function checkWin()
    local vx = {}
    vx[1],vx[2]=0,0
    local vy = {}
    vy[1],vy[2]=0,0
    local sumvx, sumvy = {},{}
    sumvx[1],sumvy[1]=0,0
    sumvx[2],sumvy[2]=0,0

    local tong = {}
    tong[1],tong[2]=0,0

    vx[1], vy[1] = ball.red:getLinearVelocity()
    sumvx[1] = vx[1] + sumvx[1]
    sumvy[1] = vy[1] + sumvy[1]

    vx[2], vy[2] = ball.blue:getLinearVelocity()
    sumvx[2] = vx[2] + sumvx[2]
    sumvy[2] = vy[2] + sumvy[2]

    for i = 1, 2 do
        tong[i] = math.sqrt(sumvx[i]^2+sumvy[i]^2)
    end
    --print(tong[1],tong[2])
    if count == 2 and tong[1] <= 10 and tong[2] <= 10 then
        timer.performWithDelay(50,function()
        --load data

            timer.performWithDelay(300,function()
                choice = choice + 1
                composer.gotoScene("script.level2")
            end)
        end)

        print("win")
    elseif count < 2 and tong[1] == 0 and tong[2] == 0 then
        print("lose")
    end

end
--================================

--================================
--ham choi lai level 1
local function retry(self,event)
    audio.play(audio.loadSound("audio/button_press.mp3"),{loops = 0})
    count = 0
    isCheck = false
    rec.tar_3.collision = nil
    rec.tar_3:removeEventListener("collision",rec.tar_3)
    rec.tar_6.collision = nil
    rec.tar_6:removeEventListener("collision",rec.tar_6)

    ball.red.bodyType = "static"
    ball.blue.bodyType = "static"
    steel[1].bodyType = "static"
    ball.red.x = ball.red.dx
    ball.red.y = ball.red.dy
    ball.blue.x = ball.blue.dx
    ball.blue.y = ball.blue.dy
    steel[1].x = steel[1].dx
    steel[1].y = steel[1].dy
    ball.red.bodyType = "dynamic"
    ball.blue.bodyType = "dynamic"
    steel[1].bodyType = "dynamic"

    display.remove(gRopes1)
    gRopes1 = display.newGroup()
    setRope()
    --bg:addEventListener("touch", drawLine)
    rec.tar_3.collision = onCollTargetRed
    rec.tar_3:addEventListener("collision",rec.tar_3)
    rec.tar_6.collision = onCollTargetBlue
    rec.tar_6:addEventListener("collision",rec.tar_6)

end
--================================


function scene:create(event)
    print("create level1")
    local g = self.view


end

function scene:show(event)
    local g = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
        physics.start()
        print("show level1")
        --rope = {}
        isCheck = false
        count = 0
        gRopes1 = display.newGroup()
        txt.text = "Level 1"
        txt.alpha = 0.5
        g:insert(bg)
        g:insert(sound)
        g:insert(rec.bottom)
        g:insert(rec.left)
        g:insert(rec.right)
        g:insert(btMenu)
        g:insert(txt)
        g:insert(gRopes1)
        g:insert(steel[1])
        steel[1].dx = 280
        steel[1].dy = 70
        steel[1].x = steel[1].dx
        steel[1].y = steel[1].dy
        steel[1].xScale = 1
        steel[1].yScale = 1

        g:insert(ball.red)
        ball.red.dx = h/2+80
        ball.red.dy =  146
        ball.red.x = ball.red.dx
        ball.red.y = ball.red.dy
        ball.red.name = "red"
        ball.red.xScale = 1
        ball.red.yScale = 1

        g:insert(ball.blue)
        ball.blue.dx = h/2+40
        ball.blue.dy =  h/2+25
        ball.blue.x = ball.blue.dx
        ball.blue.y = ball.blue.dy
        ball.blue.name = "blue"
        ball.blue.xScale = 1
        ball.blue.yScale = 1


        rec[1] = display.newImage("image/rect_stone3.png")
        g:insert(rec[1])
        rec[1].x = w/2 - 20
        rec[1].y = 200

        rec[2] = display.newImage("image/rect_stone3.png")
        g:insert(rec[2])
        rec[2].x = h/4 +90
        rec[2].y = 320

        rec[3] = display.newImage("image/rect_stone3.png")
        g:insert(rec[3])
        rec[3].x = h/4+195
        rec[3].y = h*3/4 - 27
        rec[3].rotation = 10

        target1 = display.newGroup()
        target2 = display.newGroup()
        g:insert(target1)
        g:insert(target2)


        --add su kien vat ly cho cac doi tuong
        physics.addBody(ball.red,"dynamic",{frition = 0.1,bounce= 0.5,density = 1, radius = 28})
        physics.addBody(ball.blue,"dynamic",{frition = 0.1,bounce= 0.5,density = 1,radius = 28})
        physics.addBody(steel[1],"dynamic",{frition = 1,bounce= 0.1,density = 5,radius = 23})

        physics.addBody(rec.bottom,"static")
        physics.addBody(rec.left,"static")
        physics.addBody(rec.right,"static")
        physics.addBody(rec[1],"static")
        physics.addBody(rec[2],"static")
        physics.addBody(rec[3],"static")


        --ham luc vien bi
        ball.red.linearDamping = 0.5
        ball.blue.linearDamping = 0.5
        steel[1].linearDamping = 0.3
        --goi lai cac ham trong level 1
        --cai dat cac soi day

        setRope()

        setTarget1(w/2+130,h/2+30)
        setTarget2(w/2+150,h-28)
        --them su kien khi ve mot duong thang de cat soi day

        --button retry
        btRetry = widget.newButton{
            --width = 128,
            --height = 128,
            --defaultFile = "image/play1.png",
            --overFile = "image/play.png",
            label = "Retry",
            font = native.systemFont,
            fontSize = 50,
            labelColor = { default={1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            onPress = function()
                audio.play(audio.loadSound("audio/button_press.mp3"),{loops = 0})
            end,
            onRelease = function()
                retry()
            end
        }
        btRetry.x = w - 80
        btRetry.y = 25
        g:insert(btRetry)
        btMenu.x = w - 80
        btMenu.y = 75

        bg:addEventListener("touch", drawLine)
        --them su kien hop va cham vao qua bong

        rec.tar_3.collision = onCollTargetRed
        rec.tar_3:addEventListener("collision",rec.tar_3)
        rec.tar_6.collision = onCollTargetBlue
        rec.tar_6:addEventListener("collision",rec.tar_6)
        timer1 = timer.performWithDelay(500,function()
            if isCheck == true then
                timer2 =  timer.performWithDelay(500,checkWin,1)
            end

        end,-1)

    end
end

function scene:hide(event)
    local g = self.view
    local phase = event.phase

    if phase == "will" then
        timer.cancel(timer1)
        if isCheck == true then
            timer.cancel(timer2)
        end

    elseif phase == "did" then
        print("hide level1")
        display.remove(gRopes1)
        physics.stop()

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
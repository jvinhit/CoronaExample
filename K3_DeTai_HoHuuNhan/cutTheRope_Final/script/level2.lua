print("level2")
local composer = require("composer")
local scene = composer.newScene()
local widget = require ("widget")
local physics = require("physics")
physics.start()
--physics.setDrawMode("hybrid")


local timer1
local timer2
local oldx, oldy = 0,0
local gRopes1 = display.newGroup()
local gRopes2 = display.newGroup()
local gRopes3 = display.newGroup()
local gRopes4 = display.newGroup()
local gRopes5 = display.newGroup()
---=============================================================================================
--cac ham dung trong level 2
---=============================================================================================

--================================
--cai dat cac day thung trong level 2
local function setRope2()
    timer.performWithDelay(10,function()
        local x,y = 0,0
        y = math.sin(math.rad(rec[2].rotation)) * 120
        x = 120 - math.cos(math.rad(rec[2].rotation)) * 120
        cir[1].x = 280 + x
        cir[1].y = h - 220 + y*-1

        cir[3].x = w/2 + 120 - x
        cir[3].y = h - 220 + y
    end,0)
    --rope 1
    local i = 0
    local dx = w/2 + 30
    local dy = 0
    local j = 0
    for i=1,10 do
        j=j+8
        rope[i] =  display.newImage("image/rect_stone_small.png",dx+j, (dy)+i*10)
        rope[i].name = "rope"
        rope[i].num = i
        physics.addBody(rope[i],"dynamic",{frition = 0.1,bounce= 0.1,density = 10,isSensor = true})
        gRopes1:insert(rope[i])
        if (i == 1) then
            rope[i].bodyType = "static"
        end
        if(i == 2) then
            --lien ket rope1 voi rope2
            physics.newJoint('pivot', rope[1], rope[i], rope[1].x, rope[1].y)
        end
        if(i > 2) then
            --lien ket rope sau no voi rope truoc no
            physics.newJoint('pivot', rope[i-1], rope[i], rope[i].x, rope[i].y)
        end
        if(i == 10) then
            --lien ket rope cuoi cung voi qua bi sat
            physics.newJoint('pivot', rope[i], ball.red, ball.red.x, ball.red.y)
            rope[i].density = 10

        end
    end
    --rope 2
    dx = w/2+210
    dy = 0
    i = 11
    j= 0
    for i=11,20 do
        j= j - 8
        rope[i] =  display.newImage("image/rect_stone_small.png",dx + j, (dy)+(i-10)*10)
        rope[i].name = "rope"
        rope[i].num = i
        physics.addBody(rope[i],"dynamic",{frition = 0.1,bounce= 0.1,density = 10,isSensor = true})
        gRopes2:insert(rope[i])
        if (i == 11) then
            rope[i].bodyType = "static"
        end
        if(i == 12) then
            --lien ket rope1 voi rope2
            physics.newJoint('pivot', rope[11], rope[i], rope[11].x, rope[11].y)
        end
        if(i > 12) then
            --lien ket rope sau no voi rope truoc no
            physics.newJoint('pivot', rope[i-1], rope[i], rope[i].x, rope[i].y)
        end
        if(i == 20) then
            --lien ket rope cuoi cung voi qua bi sat
            physics.newJoint('pivot', rope[i], ball.red, ball.red.x, ball.red.y)
            rope[i].density = 10
        end
    end
    --rope 3
    dx = w/2 - 120
    dy = 0
    i = 0
    j= 0
    for i=21,30 do
        j= j - 5
        rope[i] =  display.newImage("image/rect_stone_small.png",dx, (dy)+(i-20)*10)
        rope[i].name = "rope"
        rope[i].num = i
        physics.addBody(rope[i],"dynamic",{frition = 0.1,bounce= 0.1,density = 10})
        gRopes3:insert(rope[i])
        if (i == 21) then
            rope[i].bodyType = "static"
        end
        if(i == 22) then
            --lien ket rope1 voi rope2
            physics.newJoint('pivot', rope[21], rope[i], rope[21].x, rope[21].y)
        end
        if(i > 22) then
            --lien ket rope sau no voi rope truoc no
            physics.newJoint('pivot', rope[i-1], rope[i], rope[i].x, rope[i].y)
        end
        if(i == 30) then
            --lien ket rope cuoi cung voi qua bi sat
            physics.newJoint('pivot', rope[i], ball.blue, ball.blue.x, ball.blue.y)
            rope[i].density = 10
        end
    end
    --rope 4
    dx = w/2 - 120
    dy = h - 220
    i = 0

    for i=31,35 do
        rope[i] =  display.newImage("image/rect_stone_small.png",dx, (dy)+(i-30)*10)
        rope[i].name = "rope"
        rope[i].num = i
        physics.addBody(rope[i],"dynamic",{frition = 0.1,bounce= 0.1,density = 1,isSensor = true})
        gRopes4:insert(rope[i])

        if(i == 31) then
            --lien ket rope1 voi rope2
            physics.newJoint('pivot', rope[i], cir[1], rope[i].x, rope[i].y)
        end

        if(i >= 32) then
            --lien ket rope sau no voi rope truoc no
            physics.newJoint('pivot', rope[i-1], rope[i], rope[i].x, rope[i].y)
        end

        if(i == 35) then
            --lien ket rope cuoi cung voi qua bi sat
            physics.newJoint('pivot', rope[i], rec[3], rec[3].x, rec[3].y)
            rope[i].density = 10
        end
    end

    --rope 5
    dx = w/2 + 120
    dy = h - 220
    i = 0
    for i=36,40 do
        rope[i] =  display.newImage("image/rect_stone_small.png",dx, (dy)+(i-35)*10)
        rope[i].name = "rope"
        rope[i].num = i
        physics.addBody(rope[i],"dynamic",{frition = 0.1,bounce= 0.1,density = 1,isSensor = true})
        gRopes5:insert(rope[i])
        if(i == 36) then
            --lien ket rope1 voi rope2
            physics.newJoint('pivot', rope[i], cir[3], rope[i].x, rope[i].y)
        end

        if(i >= 37) then
            --lien ket rope sau no voi rope truoc no
            physics.newJoint('pivot', rope[i-1], rope[i], rope[i].x, rope[i].y)
        end

        if(i == 40) then
            --lien ket rope cuoi cung voi qua bi sat
            physics.newJoint('pivot', rope[i], rec[4], rec[4].x, rec[4].y)
            rope[i].density = 10
        end
    end
end
--================================

--================================
--xu ly su kien khi duong thang va soi day va cham
local function ropeCollision2(e)
    --print(e.other.name, e.other.num)
    if(e.other.name == "rope") then
        local num = e.other.num
        local play = audio.loadSound("audio/rope_swish.mp3")
        audio.play(play,{loops = 0})
        if num > 1 and num <= 10 then
            for i=num,10 do
                display.remove(rope[i])
            end
        elseif num > 10 and num <=20 then
            for i=num,20 do
                display.remove(rope[i])
            end
        elseif num >20 and num <=30 then
            for i=num,30 do
                display.remove(rope[i])
            end
        elseif num > 30 and num <=35 then
            for i=num,35 do
                display.remove(rope[i])
            end
        elseif num >35 and num <=40 then
            for i=num,40 do
                display.remove(rope[i])
            end
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
        oldx = e.x
        oldy = e.y
    elseif(e.phase == 'moved') then
        line = display.newLine(oldx, oldy,e.x,e.y)
        oldx = e.x
        oldy = e.y
        line.strokeWidth = 2
        physics.addBody(line, 'static')
        line.isSensor = true
        line:addEventListener('collision', ropeCollision2)
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
        local play = audio.loadSound("audio/count_win.mp3")
        audio.play(play,{loops = 0})
        count = count + 1
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
                composer.gotoScene("script.level3")
            end)
        end)
        print("win")
    elseif count < 2 and tong[1] == 0 and tong[2] == 0 then
        print("lose")
    end

end
--================================

--================================
--choi lai level 2
local function retry2(event)
    audio.play(audio.loadSound("audio/button_press.mp3"),{loops = 0})
    isCheck = false
    count = 0

    rec.tar_3.collision = nil
    rec.tar_3:removeEventListener("collision",rec.tar_3)
    rec.tar_6.collision = nil
    rec.tar_6:removeEventListener("collision",rec.tar_6)

    ball.red.bodyType = "static"
    ball.blue.bodyType = "static"
    rec[2].bodyType = "static"
    rec[3].bodyType = "static"
    rec[4].bodyType = "static"
    cir[1].bodyType = "static"
    cir[3].bodyType = "static"
    ball.red.x = ball.red.dx
    ball.red.y = ball.red.dy
    ball.blue.x = ball.blue.dx
    ball.blue.y = ball.blue.dy
    rec[2].rotation = 0
    rec[3].x = rec[3].dx
    rec[3].y = rec[3].dy
    rec[4].x = rec[4].dx
    rec[4].y = rec[4].dy
    cir[1].x = cir[1].dx
    cir[1].y = cir[1].dy
    cir[3].x = cir[3].dx
    cir[3].y = cir[3].dy
    ball.red.bodyType = "dynamic"
    ball.blue.bodyType = "dynamic"
    rec[2].bodyType = "dynamic"
    rec[3].bodyType = "dynamic"
    rec[4].bodyType = "dynamic"
    cir[1].bodyType = "dynamic"
    cir[3].bodyType = "dynamic"

    display.remove(gRopes1)
    display.remove(gRopes2)
    display.remove(gRopes3)
    display.remove(gRopes4)
    display.remove(gRopes5)

    gRopes1 = display.newGroup()
    gRopes2 = display.newGroup()
    gRopes3 = display.newGroup()
    gRopes4 = display.newGroup()
    gRopes5 = display.newGroup()

    setRope2()
    --bg:addEventListener("touch", drawLine)
    rec.tar_3.collision = onCollTargetRed
    rec.tar_3:addEventListener("collision",rec.tar_3)
    rec.tar_6.collision = onCollTargetBlue
    rec.tar_6:addEventListener("collision",rec.tar_6)
end
--================================

function scene:create(event)
    local g = self.view

end

function scene:show(event)
    local g = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
        physics.start()
        print("show level 2")
        rope = {}
        isCheck = false
        count = 0

        gRopes1 = display.newGroup()
        gRopes2 = display.newGroup()
        gRopes3 = display.newGroup()
        gRopes4 = display.newGroup()
        gRopes5 = display.newGroup()
        txt.text = "Level 2"
        g:insert(bg)
        g:insert(bg)
        g:insert(sound)
        g:insert(rec.bottom)
        g:insert(rec.left)
        g:insert(rec.right)

        g:insert(btMenu)
        g:insert(txt)

        g:insert(ball.red)
        ball.red.dx = w/2 + 120
        ball.red.dy =  100
        ball.red.x = ball.red.dx
        ball.red.y = ball.red.dy
        ball.red.name = "red"
        ball.red.xScale = 1
        ball.red.yScale = 1

        g:insert(ball.blue)
        ball.blue.dx = w/2 - 120
        ball.blue.dy =  100
        ball.blue.x = ball.blue.dx
        ball.blue.y = ball.blue.dy
        ball.blue.name = "blue"
        ball.blue.xScale = 1
        ball.blue.yScale = 1



        rec[1] = display.newImage("image/rect_stone4.png")
        g:insert(rec[1])
        rec[1].rotation = 90
        rec[1].x = w/2
        rec[1].y = h-120


        rec[2] = display.newImage("image/rect_stone6.png")
        g:insert(rec[2])
        rec[2].dx = w/2
        rec[2].dy = h-220
        rec[2].x = rec[2].dx
        rec[2].y = rec[2].dy


        rec[9] = display.newRect(0,0,50,150)
        g:insert(rec[9])
        rec[9].dx = w/2
        rec[9].dy = h-80
        rec[9].x = rec[9].dx
        rec[9].y = rec[9].dy
        rec[9].alpha = 0


        rec[3] = display.newImage("image/rect_stone1.png")
        g:insert(rec[3])
        rec[3].dx = w/2 - 120
        rec[3].dy = h/2+90
        rec[3].x = rec[3].dx
        rec[3].y = rec[3].dy


        rec[4] = display.newImage("image/rect_stone1_4.png")
        g:insert(rec[4])
        rec[4].dx = w/2 + 120
        rec[4].dy = h/2 + 90
        rec[4].x = rec[4].dx
        rec[4].y = rec[4].dy


        rec[5] = display.newImage("image/rect_stone2.png")
        g:insert(rec[5])
        rec[5].x = 60
        rec[5].y = h - 220


        rec[6] = display.newImage("image/rect_stone2.png")
        g:insert(rec[6])
        rec[6].x = w - 60
        rec[6].y = h-220


        rec[7] = display.newImage("image/rect_stone1_2.png")
        g:insert(rec[7])
        rec[7].x = w/2 - 50
        rec[7].y = h/2 + 70

        rec[8] = display.newImage("image/rect_stone1_2.png")
        g:insert(rec[8])
        rec[8].x = w/2 + 50
        rec[8].y = h/2 + 70


        cir[1] = display.newCircle(0,0,10)
        g:insert(cir[1])
        cir[1].dx = w/2 - 120
        cir[1].dy = h - 220
        cir[1].x = cir[1].dx
        cir[1].y = cir[1].dy
        cir[1]:setFillColor(0.57,0.57,0.57)

        cir[2] = display.newCircle(0,0,10)
        g:insert(cir[2])
        cir[2].x = w/2
        cir[2].y = h - 220
        cir[2]:setFillColor(0.57,0.57,0.57)

        cir[3] = display.newCircle(0,0,10)
        g:insert(cir[3])
        cir[3].dx = w/2 + 120
        cir[3].dy = h - 220
        cir[3].x = cir[3].dx
        cir[3].y = cir[3].dy
        cir[3]:setFillColor(0.57,0.57,0.57)

        target1 = display.newGroup()
        target2 = display.newGroup()
        g:insert(target1)
        g:insert(target2)

        --them su kien physics cho cac doi tuong

        physics.addBody(rec.bottom,"static")
        physics.addBody(rec.left,"static")
        physics.addBody(rec.right,"static")
        physics.addBody(rec[1],"static",{friction = 1,bounce = 0.1,density=1,isSensor = true})
        physics.addBody(rec[2],"dynamic",{friction = 1,bounce = 0,density=3})
        physics.addBody(rec[3],"dynamic",{friction = 1,bounce = 0.1,density=3})
        physics.addBody(rec[4],"dynamic",{friction = 1,bounce = 0.1,density=2})
        physics.addBody(rec[5],"static",{friction = 1,bounce = 0.1,density=1})
        physics.addBody(rec[6],"static",{friction = 1,bounce = 0.1,density=1})
        physics.addBody(rec[7],"static",{friction = 1,bounce = 0.1,density=1})
        physics.addBody(rec[8],"static",{friction = 1,bounce = 0.1,density=1})
        physics.addBody(rec[9],"static",{friction = 1,bounce = 0.1,density=1})

        physics.addBody(cir[1],"dynamic",{friction = 1,bounce = 0.1,density=6,radius = 10,isSensor = true})
        physics.addBody(cir[2],"static",{friction = 1,bounce = 0.1,density=7,radius = 10,isSensor = true})
        physics.addBody(cir[3],"dynamic",{friction = 1,bounce = 0.1,density=6,radius = 10,isSensor = true})



        physics.addBody(ball.red,{friction = 1,bounce = 0.5,density = 1,radius = 28})
        physics.addBody(ball.blue,{friction = 1,bounce = 0.5,density = 1,radius = 28})
        --tao bap benh
        physics.newJoint('pivot', cir[2], rec[2], cir[2].x, cir[2].y)
        physics.newJoint('pivot', rec[2], cir[1], cir[1].x, cir[1].y)
        physics.newJoint('pivot', rec[2], cir[3], cir[3].x, cir[3].y)
        --tao luc ham lai cua vien bi
        ball.red.linearDamping = 0.3
        ball.blue.linearDamping = 0.3
        --code xu ly trong level 2
        setRope2()
        setTarget1(130,h-28)
        setTarget2(w-130,h-28)

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
                retry2()
            end
        }
        btRetry.x = w - 80
        btRetry.y = 25
        g:insert(btRetry)
        btMenu.x = w - 80
        btMenu.y = 75

        --them su kien khi ve mot duong thang de cat soi day
        bg:addEventListener("touch", drawLine)
        --choi lai level 2

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
        display.remove(gRopes1)
        display.remove(gRopes2)
        display.remove(gRopes3)
        display.remove(gRopes4)
        display.remove(gRopes5)
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
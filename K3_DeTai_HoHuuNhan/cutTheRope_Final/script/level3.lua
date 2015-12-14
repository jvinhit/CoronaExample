print("level3")
local composer = require("composer")
local scene = composer.newScene()
local widget = require ("widget")
local physics = require("physics")
physics.start()
--physics.setDrawMode("hybrid")

local timer1
local timer2
local timer3
local oldx, oldy = 0,0
gRopes1 = display.newGroup()
gRopes2 = display.newGroup()
gRopes3 = display.newGroup()
gRopes4 = display.newGroup()
gRopes5 = display.newGroup()
---=============================================================================================
--cac ham dung trong level 3
---=============================================================================================

--======================================================---
--cai dat cac rope trong level 3
local function setRope3()
    --rope 1
    local i = 0
    local dx = 170
    local dy = 0
    local j = 0
    for i=1,5 do
        rope[i] =  display.newImage("image/rect_stone_small.png",dx, (dy)+i*10)
        rope[i].name = "rope"
        rope[i].num = i
        physics.addBody(rope[i],"dynamic",{frition = 0.1,bounce= 0.1,density = 5})
        gRopes1:insert(rope[i])
        if (i == 1) then
            rope[i].bodyType = "static"
        end
        if(i == 2) then
            --lien ket rope1 voi rope2
            physics.newJoint('pivot', rope[1], rope[i], rope[i].x, rope[i].y)
        end

        if(i > 2) then
            --lien ket rope sau no voi rope truoc no
            physics.newJoint('pivot', rope[i-1], rope[i], rope[i].x, rope[i].y)
        end

        if(i == 5) then
            --lien ket rope cuoi cung voi qua bi sat
            physics.newJoint('pivot', rope[i], steel[1], steel[1].x, steel[1].y)

        end
    end
    --rope 2
    dx = w/2 + 160
    dy = 0

    for i=6,10 do
        rope[i] =  display.newImage("image/rect_stone_small.png",dx, (dy)+(i-5)*10)
        rope[i].name = "rope"
        rope[i].num = i
        physics.addBody(rope[i],"dynamic",{frition = 0.1,bounce= 0.1,density = 5})
        gRopes2:insert(rope[i])
        if (i == 6) then
            rope[i].bodyType = "static"
        end
        if(i == 7) then
            --lien ket rope1 voi rope2
            physics.newJoint('pivot', rope[6], rope[i], rope[i].x, rope[i].y)
        end

        if(i > 7) then
            --lien ket rope sau no voi rope truoc no
            physics.newJoint('pivot', rope[i-1], rope[i], rope[i].x, rope[i].y)
        end

        if(i == 10) then
            --lien ket rope cuoi cung voi qua bi sat
            physics.newJoint('pivot', rope[i], steel[2], steel[2].x, steel[2].y)

        end
    end
    --rope 3
    dx = w - 90
    dy = -20

    for i=11,15 do
        rope[i] =  display.newImage("image/rect_stone_small.png",dx, (dy)+(i-10)*10)
        rope[i].name = "rope"
        rope[i].num = i
        physics.addBody(rope[i],"dynamic",{frition = 0.1,bounce= 0.1,density = 5})
        gRopes3:insert(rope[i])
        if (i == 11) then
            rope[i].bodyType = "static"
        end
        if(i == 12) then
            --lien ket rope1 voi rope2
            physics.newJoint('pivot', rope[11], rope[i], rope[i].x, rope[i].y)
        end

        if(i > 12) then
            --lien ket rope sau no voi rope truoc no
            physics.newJoint('pivot', rope[i-1], rope[i], rope[i].x, rope[i].y)
        end

        if(i == 15) then
            --lien ket rope cuoi cung voi qua bi sat
            physics.newJoint('pivot', rope[i], steel[3], steel[3].x, steel[3].y)

        end
    end

    --rope 4
    dx = 200
    dy = h/2 -20
    j = 0
    for i=16,23 do
        j = j - 10
        rope[i] =  display.newImage("image/rect_stone_small.png",dx+j, (dy)+(i-15)*10)
        physics.addBody(rope[i],"dynamic",{frition = 0.1,bounce= 0.1,density = 10})
        rope[i].name = "rope"
        rope[i].num = i
        gRopes4:insert(rope[i])
        if (i == 16) then
            rope[i].bodyType = "static"
            rope[i].isSensor = true
        end
        if(i == 17) then
            --lien ket rope1 voi rope2
            physics.newJoint('pivot', rope[16], rope[i], rope[16].x, rope[16].y)
        end

        if(i > 17) then
            --lien ket rope sau no voi rope truoc no
            physics.newJoint('pivot', rope[i-1], rope[i], rope[i].x, rope[i].y)
        end

        if(i == 23) then
            --lien ket rope cuoi cung voi qua bi sat
            rope[i].x = 110
            rope[i].y = 280
            physics.newJoint('pivot', rope[i], steel[4], steel[4].x, steel[4].y)


        end

    end

    --rope 5
    dx = 50
    dy = h/2 -20
    j = 0
    for i=24,29 do
        j = j + 10
        rope[i] =  display.newImage("image/rect_stone_small.png",dx + j, (dy)+(i-23)*10)
        rope[i].name = "rope"
        rope[i].num = i
        physics.addBody(rope[i],"dynamic",{frition = 0.1,bounce= 0.1,density = 10})
        gRopes5:insert(rope[i])

        if(i == 24) then
            --lien ket rope1 voi rope2
            rope[i].bodyType = "static"
        end
        if(i == 25) then
            --lien ket rope1 voi rope2
            physics.newJoint('pivot', rope[24], rope[i], rope[24].x, rope[24].y)
        end
        if(i > 25) then
            --lien ket rope sau no voi rope truoc no
            physics.newJoint('pivot', rope[i-1], rope[i], rope[i].x, rope[i].y)
        end

        if(i == 29) then
            --lien ket rope cuoi cung voi qua bi sat
            physics.newJoint('pivot', rope[i], steel[4],steel[4].x, steel[4].y)
            --rope[i].density = 10
            print(rope[i].x,rope[i].y)
        end
    end



end
--======================================================---

--================================
--xu ly su kien khi duong thang va soi day va cham
local function ropeCollision3(e)
    print(e.other.name, e.other.num)
    if(e.other.name == "rope") then
        local num = e.other.num
        local play = audio.loadSound("audio/rope_swish.mp3")
        audio.play(play,{loops = 0})

        if num >= 1 and num <= 5 then
            for i=num,5 do
                display.remove(rope[i])
            end
        elseif num >=6 and num <=10 then
            for i=num,10 do
                display.remove(rope[i])
            end
        elseif num >=11 and num <=15 then
            for i=num,15 do
                display.remove(rope[i])
            end
        elseif num >=16 and num <=23 then
            for i=num,23 do
                display.remove(rope[i])
            end
        elseif num >=24 and num <=29 then
            for i=num,29 do
                display.remove(rope[i])
            end
        end
        isCheck = true
    end
end
--================================

--================================
--xu ly su kien khi va cham
local function onCollRed(self,event)
    print(event.other.name)
    if event.other.name == "tar_red"then
        local play = audio.loadSound("audio/count_win.mp3")
        audio.play(play,{loops = 0})
        count = count + 1
        self:removeEventListener("collision",self)
    end
    print(count)
end
local function onCollTargetRed(self,event)
    print(event.other.name)
    if event.other.name == "red"then
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
        line:addEventListener('collision', ropeCollision3)
        lines:insert(line)
    elseif(e.phase == 'ended') then
        display.remove(lines)
        lines = nil
        lines = display.newGroup()
    end
end
--================================

--================================
--kiem tra dieu kien khi qua man
local function checkWin()
    local vx = {}
    vx[1],vx[2],vx[3]=0,0,0
    local vy = {}
    vy[1],vy[2],vy[3]=0,0,0
    local sumvx, sumvy = {},{}
    sumvx[1],sumvy[1],sumvx[3]=0,0,0
    sumvx[2],sumvy[2],sumvy[3]=0,0,0

    local tong = {}
    tong[1],tong[2],tong[3]=0,0,0

    vx[1], vy[1] = ball.red:getLinearVelocity()
    sumvx[1] = vx[1] + sumvx[1]
    sumvy[1] = vy[1] + sumvy[1]

    vx[2], vy[2] = ball.blue:getLinearVelocity()
    sumvx[2] = vx[2] + sumvx[2]
    sumvy[2] = vy[2] + sumvy[2]

    vx[3], vy[3] = ball.red2:getLinearVelocity()
    sumvx[3] = vx[3] + sumvx[3]
    sumvy[3] = vy[3] + sumvy[3]


    for i = 1, 3 do
        tong[i] = math.sqrt(sumvx[i]^2+sumvy[i]^2)
    end
    --print(tong[1],tong[2])
    if count == 3 and tong[1] <= 10 and tong[2] <= 10 and tong[3] <= 10 then
        timer.performWithDelay(50,function()
        --load data

            timer.performWithDelay(300,function()
                choice = choice + 1
                composer.gotoScene("script.win")
            end)
        end)
        print("win")
    elseif count < 3 and tong[1] == 0 and tong[2] == 0 and tong[3] == 0 then
        print("lose")
    end

end
--================================

--================================
--choi lai level 2
local function retry3(event)
    audio.play(audio.loadSound("audio/button_press.mp3"),{loops = 0})
    isCheck = false
    count = 0

    rec.tar_6.collision = onCollTargetBlue
    rec.tar_6:removeEventListener("collision",rec.tar_6)
    ball.red.collision = onCollRed
    ball.red:removeEventListener("collision",ball.red)
    ball.red2.collision = onCollRed
    ball.red2:removeEventListener("collision",ball.red2)

    ball.red.bodyType = "static"
    ball.blue.bodyType = "static"
    ball.red2.bodyType = "static"
    steel[1].bodyType = "static"
    steel[2].bodyType = "static"
    steel[3].bodyType = "static"
    steel[4].bodyType = "static"
    --rec[5].bodyType = "static"

    ball.red.x = ball.red.dx
    ball.red.y = ball.red.dy
    ball.red2.x = ball.red2.dx
    ball.red2.y = ball.red2.dy
    ball.blue.x = ball.blue.dx
    ball.blue.y = ball.blue.dy
    for i=1,4 do
        steel[i].x = steel[i].dx
        steel[i].y = steel[i].dy
    end
    rec[5].x = rec[5].dx
    rec[5].y = rec[5].dy

    ball.red.bodyType = "dynamic"
    ball.blue.bodyType = "dynamic"
    ball.red2.bodyType = "dynamic"
    steel[1].bodyType = "dynamic"
    steel[2].bodyType = "dynamic"
    steel[3].bodyType = "dynamic"
    steel[4].bodyType = "dynamic"

    --rec[5].bodyType = "dynamic"


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

    setRope3()
    --bg:addEventListener("touch", drawLine)
    rec.tar_6.collision = onCollTargetBlue
    rec.tar_6:addEventListener("collision",rec.tar_6)
    ball.red.collision = onCollRed
    ball.red:addEventListener("collision",ball.red)
    ball.red2.collision = onCollRed
    ball.red2:addEventListener("collision",ball.red2)
end
--================================

--================================
--dat lai hinh hop do
local function setTarget_1(dx,dy)
    rec.tar1 = display.newRect(dx-62,dy-30,15,60)
    rec.tar2 = display.newRect(dx+62,dy-30,15,60)
    rec.tar3 = display.newRect(dx,dy,140,15)
    rec.tar_1 = display.newRect(dx-55,dy-30,2,55)
    rec.tar_2 = display.newRect(dx+55,dy-30,2,55)
    rec.tar_3 = display.newRect(dx,dy-8,120,2)
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
    physics.addBody(rec.tar1,"static",{friction =1,bounce = 0.1,density = 1})
    physics.addBody(rec.tar2,"static",{friction =1,bounce = 0.1,density = 1})
    physics.addBody(rec.tar3,"static",{friction =1,bounce = 0.1,density = 1})
    physics.addBody(rec.tar_1,"static",{friction =1,bounce = 0.1,density = 1})
    physics.addBody(rec.tar_2,"static",{friction =1,bounce = 0.1,density = 1})
    physics.addBody(rec.tar_3,"static",{friction =1,bounce = 0.1,density = 1})

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
        print("show level3")

        rope = {}
        isCheck = false
        count = 0

        txt.text = " Level 3"
        gRopes1 = display.newGroup()
        gRopes2 = display.newGroup()
        gRopes3 = display.newGroup()
        gRopes4 = display.newGroup()
        gRopes5 = display.newGroup()

        g:insert(bg)
        g:insert(sound)
        --ve giao dien level 3
        g:insert(rec.bottom)
        g:insert(rec.left)
        g:insert(rec.right)
        g:insert(btMenu)
        g:insert(txt)

        g:insert(steel[1])
        steel[1].dx = 170
        steel[1].dy = 50
        steel[1]. x = steel[1].dx
        steel[1].y = steel[1].dy
        steel[1].xScale = -0.8
        steel[1].yScale = -0.8

        g:insert(steel[2])
        steel[2].dx = w/2 + 160
        steel[2].dy = 50
        steel[2]. x = steel[2].dx
        steel[2].y = steel[2].dy
        steel[2].xScale = -0.8
        steel[2].yScale = -0.8

        g:insert(steel[3])
        steel[3].dx = w - 90
        steel[3].dy = 30
        steel[3]. x = steel[3].dx
        steel[3].y = steel[3].dy
        steel[3].xScale = -0.8
        steel[3].yScale = -0.8

        g:insert(steel[4])
        steel[4].dx = 110
        steel[4].dy = 280
        steel[4]. x = steel[4].dx
        steel[4].y = steel[4].dy
        steel[4].xScale = -0.8
        steel[4].yScale = -0.8

        g:insert(ball.red)
        ball.red.dx = 200
        ball.red.dy =  h/2 - 104
        ball.red.x = ball.red.dx
        ball.red.y = ball.red.dy
        ball.red.name = "red"
        ball.red.xScale = -0.8
        ball.red.yScale = -0.8



        g:insert(ball.blue)

        ball.blue.dx = w/2 + 140
        ball.blue.dy =  h/2 - 128
        ball.blue.x = ball.blue.dx
        ball.blue.y = ball.blue.dy
        ball.blue.name = "blue"
        ball.blue.xScale = -0.8
        ball.blue.yScale = -0.8

        g:insert(ball.red2)
        ball.red2.dx = w - 115
        ball.red2.dy =  h/2 -153
        ball.red2.x = ball.red2.dx
        ball.red2.y = ball.red2.dy
        ball.red2.name = "red2"
        ball.red2.xScale = -0.8
        ball.red2.yScale = -0.8

        rec[1] = display.newImage("image/rect_stone1.png")
        g:insert(rec[1])
        rec[1].x = 35
        rec[1].y = h/2-50

        rec[2] = display.newImage("image/rect_stone3_25.png")
        g:insert(rec[2])
        rec[2].dx = 135
        rec[2].dy = h/2 - 50
        rec[2].x = rec[2].dx
        rec[2].y = rec[2].dy

        rec[3] = display.newImage("image/rect_stone3_25.png")
        g:insert(rec[3])
        rec[3].dx = w/2 + 130
        rec[3].dy = h/2 - 75
        rec[3].x = rec[3].dx
        rec[3].y = rec[3].dy

        rec[4] = display.newImage("image/rect_stone3_25.png")
        g:insert(rec[4])
        rec[4].dx = w - 85
        rec[4].dy = h/2 - 100
        rec[4].x = rec[4].dx
        rec[4].y = rec[4].dy

        rec[5] = display.newImage("image/rect_stone3_25.png")
        g:insert(rec[5])
        rec[5].dx = w/2
        rec[5].dy = h/2 + 25
        rec[5].x = rec[5].dx
        rec[5].y = rec[5].dy

        rec[6] = display.newImage("image/rect_stone6.png")
        g:insert(rec[6])
        rec[6].x = w/2
        rec[6].y = h-45

        rec[7] = display.newImage("image/rect_stone6.png")
        g:insert(rec[7])
        rec[7].x = w/2
        rec[7].y = h - 95

        target1 = display.newGroup()
        target2 = display.newGroup()
        g:insert(target1)
        g:insert(target2)


        --them su kien vat ly
        physics.addBody(ball.red,"dynamic",{frition = 1,bounce= 0.5,density = 2, radius = 23})
        physics.addBody(ball.blue,"dynamic",{frition = 1,bounce= 0.5,density = 2,radius = 23})
        physics.addBody(ball.red2,"dynamic",{frition = 1,bounce= 0.5,density = 2,radius = 23})


        physics.addBody(rec.bottom,"static",{friction = 1, density = 1,bounce = 0.3})
        physics.addBody(rec.left,"static",{friction = 1, density = 1,bounce = 0.3})
        physics.addBody(rec.right,"static",{friction = 1, density = 1,bounce = 0.3})
        physics.addBody(rec[1],"static",{friction = 1, density = 2,bounce = 0.1})
        physics.addBody(rec[2],"static",{friction = 1, density = 2,bounce = 0.1})
        physics.addBody(rec[3],"static",{friction = 1, density = 2,bounce = 0.1})
        physics.addBody(rec[4],"static",{friction = 1, density = 2,bounce = 0.1})
        physics.addBody(rec[5],"static",{friction = 1, density = 2,bounce = 0.1})
        physics.addBody(rec[6],"static",{friction = 1, density = 2,bounce = 0.1})
        physics.addBody(rec[7],"static",{friction = 1, density = 2,bounce = 0.1})


        physics.addBody(steel[1],"dynamic",{friction = 1, density = 10,bounce = 0.1,radius = 18})
        physics.addBody(steel[2],"dynamic",{friction = 1, density = 10,bounce = 0.1,radius = 18})
        physics.addBody(steel[3],"dynamic",{friction = 1, density = 5,bounce = 0.1,radius = 18})
        physics.addBody(steel[4],"dynamic",{friction = 1, density = 10,bounce = 0.1,radius = 18})

        ball.red.linearDamping = 0.5
        ball.blue.linearDamping = 0.5
        ball.red2.linearDamping = 0.2

        setRope3()

        setTarget_1(w-170,h-25)
        setTarget2(170,h-25)
        bg:addEventListener("touch", drawLine)

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
                retry3()
            end
        }
        btRetry.x = 80
        btRetry.y = 80
        g:insert(btRetry)
        btMenu.x = 80
        btMenu.y = 130

        --lam cho thanh sat chay qua chay lai
        local q = 0
        timer1 = timer.performWithDelay(10,function()

            if q == 0 then
                rec[5].x = rec[5].x - 5
                if rec[5].x < 250 then
                    q = 1
                end
            end

            if q == 1 then
                rec[5].x = rec[5].x + 5
                if rec[5].x > 550 then
                    q = 0
                end
            end

        end,-1)

        rec.tar_6.collision = onCollTargetBlue
        rec.tar_6:addEventListener("collision",rec.tar_6)
        ball.red.collision = onCollRed
        ball.red:addEventListener("collision",ball.red)
        ball.red2.collision = onCollRed
        ball.red2:addEventListener("collision",ball.red2)

        timer2 = timer.performWithDelay(500,function()
            if isCheck == true then
                timer3 =  timer.performWithDelay(500,checkWin,1)
            end

        end,-1)

    end
end

function scene:hide(event)
    local g = self.view
    local phase = event.phase

    if phase == "will" then
        timer.cancel(timer1)
        timer.cancel(timer2)
        if isCheck == true then
            timer.cancel(timer3)
        end

    elseif phase == "did" then
        display.remove(gRopes1)
        display.remove(gRopes2)
        display.remove(gRopes3)
        display.remove(gRopes4)
        display.remove(gRopes5)
        display.remove(target1)
        display.remove(target2)
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
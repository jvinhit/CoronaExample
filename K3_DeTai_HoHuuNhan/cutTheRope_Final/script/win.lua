print("win")
local lib_emitter = require("lib.lib_emitter")
local composer = require("composer")
local scene = composer.newScene()
local timer1
local timer2
function scene:create(event)
    local g = self.view
    --audio.stop(play)

    local Random = math.random

    local screenW = display.contentWidth
    local screenH = display.contentHeight
    local screenHW = screenW *.5
    local screenHH = screenH *.5

    --Base emitter props
    local radiusRange = 100

    local duration = 1200 --800
    local startAlpha = 1
    local endAlpha = 0
    local pImage = nil
    local pImageWidth = nil
    local pImageHeight = nil
    local emitterDensity = 40

    --Mortar props
    local mortarSpeed = 200
    local mortarEmitterDensity = 40
    local mortarRadiusRange = 100
    local mortarThickness = 4
    local mortarEmitter = emitterLib:createEmitter(radiusRange, mortarThickness, duration, startAlpha, endAlpha, pImage, pImageWidth, pImageHeight)

    --Sprayer props
    local sprayerSpeed = 200
    local sprayerEmitterDensity = 40
    local sprayerRadiusRange = 70
    local sprayerThickness = 3
    local sprayerEmitter = emitterLib:createEmitter(sprayerRadiusRange, sprayerThickness, duration, startAlpha, endAlpha, pImage, pImageWidth, pImageHeight)
    --This will be a random color emitter
    sprayerEmitter:setColor(-1)

    --Keep it tidy
    local levelGroup = display.newGroup()

    local function SprayStyleEmitter(px, py)
        timer.performWithDelay(10, function()
            sprayerEmitter:emit(levelGroup, px, py)
        end, sprayerEmitterDensity)
    end

    local function ExplodeStyleEmitter(px, py)
        mortarEmitter:setColor(Random(20,255),Random(20,255),Random(20,255))

        for i=1,mortarEmitterDensity do
            mortarEmitter:emit(levelGroup, px, py)
        end
    end

    local function ShootFirework()
        local mortar = display.newRect(levelGroup, screenHW, screenH, 4, 8)
        local px = Random(30, screenW-30)
        local py = Random(30, screenH-180)

        local function mortarExplode(Obj)
            display.remove(Obj)
            Obj = nil

            --How about a little poof to boot
            local pop = display.newCircle(levelGroup, px, py, Random(10,20))
            local function DestroyPop(Obj)
                display.remove(Obj)
                Obj = nil
            end
            transition.to(pop, {time=100, alpha = 0, onComplete=DestroyPop})
            --end of extra poof code

            ExplodeStyleEmitter(px, py)
        end

        transition.to(mortar, {time=2000, x=px, y=py, onComplete=mortarExplode})
    end

    local function StartSprayer()
        local px = Random(30, screenW-30)
        local py = Random(screenH-60, screenH-30)

        SprayStyleEmitter(px, py)
    end

    local function StartShow()
        --Start mortar volley
        timer.performWithDelay(mortarSpeed, function()
            ShootFirework()
        end, 0)

        --Start srayers
        timer.performWithDelay(sprayerSpeed, function()
        --StartSprayer()
        end, 0)

        title = display.newText("YOU WIN", 0, 0, native.systemFont, 150)

        title:setTextColor(225, 160, 12)
        --title:setReferencePoint(display.CenterReferencePoint)
        title.x = w/2
        title.y = h/2
        title.alpha = 0
        timer.performWithDelay(500, function() transition.to(title, {time=4000, alpha=1}) end)
        title:addEventListener("tap",function()
            composer.gotoScene("script.menu")
        end)
    end

    StartShow()
end

function scene:show(event)
    local g = self.view
    local phase = event.phase

    if phase == "will" then

    elseif phase == "did" then
        audio.stop(play1)
        play = audio.loadSound("audio/win-sound.mp3")
        play1  = audio.play(play,{channel = 3,loops = 0})
        g:insert(bg)
        g:insert(title)
        --g.txt = display.newText("You Win",w/2,h/2,native.systemFont,100)
        --g.txt:addEventListener("tap",function()
            --composer.gotoScene("script.menu")
        --end)
        --g:insert(g.txt)
        btMenu.x = w/2
        btMenu.y = h /2 + 200
    end
end

function scene:hide(event)

    local g = self.view
    local phase = event.phase

    if phase == "will" then

    elseif phase == "did" then
        play = audio.loadSound("audio/Smooth_Session_part01.mp3")
        play1 = audio.play(play,{channel = 1,loops = -1})

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
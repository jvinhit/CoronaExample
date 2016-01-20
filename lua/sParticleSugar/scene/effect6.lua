---
-- Created by IntelliJ IDEA.
-- @author callin2@gmail.com
-- @copyright 2012 임창진
--

local storyboard = require("storyboard")
local PS = require("classes.ParticleSugar").instance()

local scene = storyboard.newScene()

function scene:createScene(event)
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene(event)
    storyboard.removeAll()
    local group = self.view

	display.newText(group, "effect 6",20,20,native.systemFont, 24)

	----------- particle begin -------------
	Runtime:addEventListener('enterFrame', PS )
	
	local dustEm = PS:newEmitter{
		name="pointLoopEm",
		x=0,y=0,
		rotation=0,
		visible=true,
		loop=false, 
		autoDestroy=false
	}
    dustEm:setParentGroup(group)
	dustEm.x = 160
	dustEm.y = 160

    PS:newParticleType{
		name="pt1",prop={
			scaleStart = 1,
			scaleVariation = 0,
			velocityStart = 30,
			velocityVariation = 100,			
			rotationStart = 0,
			rotationChange = 8,
			rotationVariation = 360,
			directionVariation = 360,
			killOutsideScreen = false,
			lifeTime = 4000,
			alphaStart = 1,
			fadeOutSpeed = -1,
			fadeOutDelay = 1550,
			scaleOutSpeed = -0.3,
		    scaleOutDelay = 1050,
			bounceX = true,
			colorStart = {255,0,0},
			shape = {
				type = 'rect',
				width = 10,
				height = 4,
			}
		}
	}
	
	PS:newParticleType{
		name="pt2",prop={
			scaleStart = 1,
			scaleVariation = 1,
			velocityStart = 50,
			velocityVariation = 30,			
			directionVariation = 360,
			killOutsideScreen = false,
			lifeTime = 2000,
			alphaStart = 1,
			fadeOutSpeed = -1,
			fadeOutDelay = 550,
			scaleOutSpeed = 0.3,
		    scaleOutDelay = 1050,
			colorStart = {255,250,0},
			shape = {
				type = 'circle',
				radius = 3,
			}
		}
	}

    PS:attachParticleType("pointLoopEm", "pt1", 500, 300, 0)
	PS:attachParticleType("pointLoopEm", "pt2", 300, 300, 0)

	----------- particle end -------------
	
	-- follow object --
	local targetObj = display.newCircle(group,160,160,10)
	
	self.tid = timer.performWithDelay(1000,function()
		-- targetObj.x = math.random(300) + 10
		-- targetObj.y = math.random(300) + 10
		
		transition.to(targetObj,{time=1000,x = math.random(300) + 10, y = math.random(300) + 10})		
	end,0)
	
	dustEm.followObjInfo = {target=targetObj,xOffset=0,yOffset=0}
	
	-------------------
	
	
	-- button --
	local caption = display.newText(group, "Prev",20,420,native.systemFont, 24)
	caption:addEventListener('touch',function(event)
		if event.phase == 'ended' then
			storyboard.gotoScene("scene.effect5")
		end
	end)
	
	local caption1 = display.newText(group, "start emit",100,420,native.systemFont, 24)
	caption1:addEventListener('touch',function()
		PS:startEmitter('pointLoopEm')
	end)
	
	local caption2 = display.newText(group, "Next",240,420,native.systemFont, 24)
	caption2:addEventListener('touch',function(event)
		if event.phase == 'ended' then
			storyboard.gotoScene("scene.effect1")
		end
	end)
	
	-- button end --
end



-- Called when scene is about to move offscreen:
function scene:exitScene(event)
    local group = self.view
	
	timer.cancel(self.tid)
	
	Runtime:removeEventListener('enterFrame', PS )
	PS:cleanUp()
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene(event)
    local group = self.view
    collectgarbage('collect')
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener("createScene", scene)

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener("enterScene", scene)

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener("exitScene", scene)

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener("destroyScene", scene)

-----------------------------------------------------------------------------------------

return scene

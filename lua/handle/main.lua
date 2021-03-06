_W = display.viewableContentWidth
_H = display.viewableContentHeight

local background =display.newRect( 0,0,_W, _H )
background:setFillColor(255,255,255)

local foo = display.newImageRect("foo.png",100,100 )
foo.name = "foo"
foo.x = _W*0.5
foo.y = _H*0.5-80

local bar = display.newImageRect("bar.png",100,100 )
bar.x = _W*0.5
bar.y = _H*0.5+80
bar.alpha = 0.1

function foo:touch(e)
	if(e.phase =="began" ) then
		display.getCurrentStage():setFocus(self)
		self.hasFocus = true
		print (self.name)
	elseif (self.hasFocus) then 
		if(e.phase=="moved") then
			self.alpha =self.alpha - 0.1;
		elseif e.phase =="ended" or e.phase =="cancelled" then 
			display.getCurrentStage():setFocus(nil)
			self.hasFocus = false
		end
	end
	return true
end

function handleTouch(e)
	if (e.phase == "began" ) then 
		-- nothing to do here
	elseif (e.phase=="moved") then
		bar.alpha = bar.alpha+0.1 
	elseif(e.phase == "ended" or e.phase == "cancelled") then
		-- nothing to do here
	end
end
foo:addEventListener( "touch", foo )
Runtime:addEventListener("enterFrame", handleTouch )
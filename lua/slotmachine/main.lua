display.setStatusBar( display.HiddenStatusBar ) --Hide status bar from the beginning

-----------------------------------------------
--*** Set up our variables and group ***
-----------------------------------------------
local slotsGroup = display.newGroup() --Setup the display groups we want
local machineGroup = display.newGroup()

local _W = display.contentWidth --Width and height parameters
local _H = display.contentHeight 
local mr = math.random

local credits = 10  --Your overall credits
local bet = 2 --Can be 1,2,3,5 
local betAllowed = true
local slotColumn1 = {}
local slotColumn2 = {}
local slotColumn3 = {}

--Create the imageSheet for our spins.
local options = 
{
	width = 100,
	height = 200,
	numFrames = 4,
	sheetContentWidth = 400,
	sheetContentHeight = 200
}
local spinSheet = graphics.newImageSheet( "images/spinSprite.jpg", options)

--Now create individual spin data.
local spinData1 = { name="spin1", start=1, count=4, time = 250, loopCount = 5 }
local spinData2 = { name="spin2", frames={ 3, 4, 1, 2}, time=250, loopCount = 5 }
local spinData3 = { name="spin3", frames={ 4, 1, 3, 2}, time=250, loopCount = 5 }

-----------------------------------------------
--*** Set up our text objects and machine ***
-----------------------------------------------
local machine = display.newImageRect("images/machineBg.png",320,480)
machine.x = _W*0.5; machine.y = _H*0.5;
machineGroup:insert(machine)

local slotCover = display.newImageRect("images/slotsCover.png",320,172)
slotCover.x = _W*0.5; slotCover.y = _H*0.358;
machineGroup:insert(slotCover)

local betText = display.newText(bet, 0,0, "Helvetica", 22)
-- betText:setReferencePoint(display.CenterLeftReferencePoint)
betText.anchorX , betText.anchorY= 0.5,1
betText.x = 30; betText.y = _H*0.68; machineGroup:insert(betText)

local creditsText = display.newText(credits, 0,0, "Helvetica", 22)
-- creditsText:setReferencePoint(display.CenterRightReferencePoint)
creditsText.anchorX, creditsText.anchorY = 0.5,0
creditsText.x = _W-30; creditsText.y = _H*0.68; machineGroup:insert(creditsText)

-----------------------------------------------
--*** Set up the visible slots ***
-----------------------------------------------
local function createSlots()
	--If theres any slots showing already remove them..
	local i
	for i = slotsGroup.numChildren,1,-1 do
		local child = slotsGroup[i]
		child.parent:remove( child )
		child = nil
	end

	--Use a loop to make them easily for us :)
	for i=1, 3 do
		local randomImage = mr(1,5)
		slotColumn1[i] = display.newImageRect("images/slot_"..randomImage..".jpg", 100, 90)
		slotColumn1[i].x = 56
		slotColumn1[i].y = _H*0.165 + (90 *(i-1))  
		slotColumn1[i].slot = randomImage
		slotsGroup:insert(slotColumn1[i])

		randomImage = mr(1,5)
		slotColumn2[i] = display.newImageRect("images/slot_"..randomImage..".jpg", 100, 90)
		slotColumn2[i].x = slotColumn1[1].x + 103
 		slotColumn2[i].y = slotColumn1[i].y
 		slotColumn2[i].slot = randomImage
		slotsGroup:insert(slotColumn2[i])
		
		randomImage = mr(1,5)
		slotColumn3[i] = display.newImageRect("images/slot_"..randomImage..".jpg", 100, 90)
		slotColumn3[i].x = slotColumn2[1].x + 103
		slotColumn3[i].y = slotColumn1[i].y 
		slotColumn3[i].slot = randomImage
		slotsGroup:insert(slotColumn3[i])
	end

	--Make it so we can bet again...
	betAllowed = true
end
createSlots()

-----------------------------------------------
--*** gameOver function.. ***
-----------------------------------------------
local function gameOver()
	--Create a blocking rect so we cant hit the buttons below
	local function blockTouch( event )
		if event.phase == "ended" then
			print("blocking Touches")
		end
		return true
	end	
	local blockRect = display.newRect(0,0,320,480)
	blockRect:setFillColor(0,0,0,180)
	blockRect:addEventListener("touch", blockTouch)
	machineGroup:insert(blockRect)

	--Now display retry text.
	local retryText
	local function restartGame( event )
		if event.phase == "ended" then
			credits = 10
			creditsText.text = credits
			creditsText:setReferencePoint(display.CenterRightReferencePoint)
			creditsText.x = _W-30

			display.remove(blockRect); blockRect = nil
			display.remove(retryText); retryText = nil

			createSlots()
	 	end
	return true
	end
	retryText = display.newText("You ran out of credits...\nClick to try again!",0,0,320,0,"Helvetica",22)
	retryText.x = _W*0.5; retryText.y = _H*0.45
	retryText:addEventListener("touch",restartGame)
	machineGroup:insert(retryText)
end

------------------------------------------------------
--*** Create the two buttons and their functions ***
------------------------------------------------------
local function changeBet( event )
	if event.phase == "ended" then
		if bet == 5 then bet = 1
		elseif bet == 3 then bet = 5
		elseif bet == 2 then bet = 3
		elseif bet == 1 then bet = 2; end

		betText.text = bet
		-- betText:setReferencePoint(display.CenterLeftReferencePoint)
		betText.anchorY = 0.5
		betText.anchorX = 0
		betText.x = 30
	end
return true
end

local function betNow( event )
	if event.phase == "ended" and betAllowed == true then
		betAllowed = false --So we cant bet until its done

		credits = credits - bet --Minus the bet amount
		creditsText.text = credits
		-- creditsText:setReferencePoint(display.CenterRightReferencePoint)
		creditsText.anchorX =1
		creditsText.anchorY =0.5


		creditsText.x = _W-30

		--Now start out spriteSheet spinning.
		local spin1, spin2, spin3
		local function spriteListener( event )
			if event.phase == "ended" then
				display.remove(spin1); spin1 = nil
				display.remove(spin2); spin2 = nil
				display.remove(spin3); spin3 = nil
				createSlots()
			end
		end

		spin1 = display.newSprite(spinSheet, spinData1)
		spin1.x = slotColumn1[2].x; spin1.y = slotColumn1[2].y
		slotsGroup:insert(spin1)

		spin2 = display.newSprite(spinSheet, spinData2)
		spin2.x = slotColumn2[2].x; spin2.y = slotColumn2[2].y
		slotsGroup:insert(spin2)

		spin3 = display.newSprite(spinSheet, spinData3)
		spin3.x = slotColumn3[2].x; spin3.y = slotColumn3[2].y
		slotsGroup:insert(spin3)

		spin1:addEventListener( "sprite", spriteListener )
		spin1:play(); spin2:play(); spin3:play()

		--Now check to see if we've won any credits back!
		local function checkSpins()
 			--Credits won that we will add later
			local addCredits = 0

			--Localise the active slot image ints. Which we 
			--set in the create slots function.
			local slotActive = {}
			slotActive[1] = slotColumn1[2].slot
			slotActive[2] = slotColumn2[2].slot
			slotActive[3] = slotColumn3[2].slot

			--Use a loop for the checks
			local i
			for i=1, 5 do
				--First check to see if 3 images match
				if slotActive[1] == i and slotActive[2] == i and slotActive[3] == i then
					--Times the amount won by your current bet.
					addCredits = 20 * bet
				--Now we have to do multiple checks to see if 2 match.	 
				elseif slotActive[1] == i and slotActive[2] == i then
					addCredits = 2 * bet
				elseif slotActive[2] == i and slotActive[3] == i then
					addCredits = 2 * bet
				elseif slotActive[1] == i and slotActive[3] == i then
					addCredits = 2 * bet
				end
			end

			--If addCredits is higher than 0 we tell the player
			if addCredits > 0 then
				credits = credits + addCredits
				creditsText.text = credits
				-- creditsText:setReferencePoint(display.CenterRightReferencePoint)
				creditsText.anchorX = 1
				creditsText.anchorY = 0.5
				creditsText.x = _W-30

				--Display how much you won..
				local winText = display.newText("You Won "..addCredits.."!",0,0,"Helvetica",32)
				winText.x = _W*0.5; winText.y = _H*0.3
				winText:setTextColor(220,40,40)
				machineGroup:insert(winText)

				--Transition it up and fade/destroy
				local trans = transition.to(winText, 
					{
						time=2000, 
						y= winText.y -30, 
						alpha = 0, 
						onComplete = function()
										display.remove(winText)
										winText = nil
									end
					})
			end

			--Now if we have run out of credits end the game!
			if credits <= 0 then
				gameOver()
			end
		end
		--Delay the check for after the spinning stops
		local delay = timer.performWithDelay(1300,checkSpins,1)
	end
return true
end

local changeBtn = display.newRect(0,0,140,50)
changeBtn.x = 80; changeBtn.y = _H*0.82; changeBtn.alpha = 0.01
changeBtn:addEventListener("touch", changeBet)
machineGroup:insert(changeBtn)

local betBtn = display.newRect(0,0,140,50)
betBtn.x = _W-80; betBtn.y = _H*0.82; betBtn.alpha = 0.01
betBtn:addEventListener("touch", betNow)
machineGroup:insert(betBtn)
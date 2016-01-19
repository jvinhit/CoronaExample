local t = {"vinh", "trang"}

print(t[1])
print("length of T " .. #t)
print(tostring(t))


local hash = {
	vinh = "vinh",
	trang = " trang"
}
local hash = {}
hash.vinh = "vinhdeptrai"
hash.trang ="trang dep gai"
print (hash["vinh"])
print (hash.vinh)

local info  ={ 
	{"vinh "," nguyen "},
	{"dau", "xanh"}, 
	more  = { 
		truong = "vinh xau trai ", 
		tuoi = 75
	}
}

print (info[1][2])

print (info.more.truong  .. ' length of more ' ..#info.more)
_W = display.contentWidth
_H = display.contentHeight
local dis = display.newImageRect("doubt.png", 100,100)
dis.x = _W*0.5
dis.y = _H*0.5
local backAndFourth
function dis:touch(e)
	if (e.phase=="began") then
		print ("touch began")
	elseif (e.phase == "moved") then 
		print( "touch moved" ) 
	elseif(e.phase=="ended" or e.phase == "cancelled") then
		print( "touch ended" )
	end 

	return true
end
local function disHandle(e)
	if (e.phase=="began") then
		print ("touch began")
	elseif (e.phase == "moved") then 
		Runtime:addEventListener( "enterFrame", backAndFourth )
		print( "touch moved" ) 
	elseif(e.phase=="ended" or e.phase == "cancelled") then
		print( "touch ended" )
		Runtime:removeEventListener( "enterFrame", backAndFourth )
	end 
end
dis:addEventListener( "touch", disHandle ) 
-- dis:addEventListener( "touch", dis ) 

local i = 0 
local n 
local Pi = math.pi


function backAndFourth(e)
	i =  i  +1
	n = (i/360) * (2*Pi)
	n = math.cos( n )
	dis.x = dis.x + n
	dis.rotation = i % 360
	--[[
	dis.xScale =n*2
	dis.yScale =n*2
	--]]
end
Runtime:addEventListener( "enterFrame", backAndFourth )


local function doIt(what, where)
	print (what.. where)
end

local love = doIt


love("Vinh&" , "Trang")


local bar= function(what, where)
	print(what .. where )
end

bar("Vinh" , "Thuy")

local function lostArgs(...)
	print(arg[1] .. arg[2])
end 
lostArgs("V", 1)

local t = {}
t.doIt =function(what, where )
	print(what .. where)
end

t.doIt("jvinhit "  , " corona sdk on night")
t.add = function(a,b)

	return a+ b
end 

local sum = t.add(4,5)
print(sum)
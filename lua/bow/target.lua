target = {}

function target:new()
	self = {}
	
	self.instance = nil
	
	self.isCollided = function(x, y)
		local result = false
		
		if x >= self.instance.x and x <= self.instance.x + self.instance.width and
			y >= self.instance.y and y <= self.instance.y + self.instance.height then 
			result = true
		end
		
		return result
	end
	
	return self
end
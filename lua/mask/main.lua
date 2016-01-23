local bg = display.newRect(0, 0, 1024, 768)
bg:setFillColor(1, 1)
bg.anchorX, bg.anchorY = 0, 0

local asset = {
    path = 'fill_1.png',
    width = 585,
    height = 134
}

local maskPath = 'tube1.png'

local grp1 = display.newGroup()
local mask1 = graphics.newMask(maskPath)
local img1 = display.newImageRect(asset.path, asset.width, asset.height)
grp1:setMask(mask1)
grp1:insert(img1)
grp1.x, grp1.y = 400, 100

local grp2 = display.newGroup()
local img2 = display.newImageRect(asset.path, asset.width, asset.height)
local mask2 = graphics.newMask(maskPath)
grp2:setMask(mask2)
grp2.x, grp2.y = 550, 250
grp2:insert(img2)

local grp3 = display.newGroup()
local mask3 = graphics.newMask(maskPath)
local img3 = display.newImageRect(asset.path, asset.width, asset.height)
grp3:setMask(mask3)
grp3:insert(img3)
grp3.x, grp3.y = 400, 400

local grp4 = display.newGroup()
local mask4 = graphics.newMask(maskPath)
local img4 = display.newImageRect(asset.path, asset.width, asset.height)
grp4:setMask(mask4)
grp4:insert(img4)
grp4.x, grp4.y = 400, 550

-- changing the z-index you can see how the masks affect each other
--grp1:toFront()
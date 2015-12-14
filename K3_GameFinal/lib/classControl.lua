local widget = require("widget")
classControl = {}
local group = display.newGroup()

group.menu = widget.newButton{
   width = 100,                        --width of the image file(s)
   height = 40,
   label = "Menu",
   font  =  native.systemFont,
   fontSize = 40,
   onRelease= function()
        --pause All
       group.bg.alpha = 1
       group.Home.alpha = 1
       group.Play.alpha = 1
       group.rePlay.alpha = 1
   end,
}
group.menu.x = 80
group.menu.y = 40
group:insert(group.menu)

group.bg = display.newRect(group,400,240,800,480)
group.bg.alpha = 0
group.bg:setFillColor(0,0,0,0.6)
group.bg:addEventListener("touch", function() return true end)
group.bg:addEventListener("tap", function() return true end)
group.alpha = 0

group.Play = widget.newButton{
    width = 100,                        --width of the image file(s)
    height = 40,
    label = "Play",
    font  =  native.systemFont,
    fontSize = 40,
    onRelease= function()
        --Resume all
        group.bg.alpha = 0
        group.Home.alpha = 0
        group.Play.alpha = 0
        group.rePlay.alpha = 0
    end,
}
group.Play.x = 400
group.Play.y = 240
group:insert(group.Play)


group.rePlay = widget.newButton{
    width = 100,                        --width of the image file(s)
    height = 40,
    label = "RePlay",
    font  =  native.systemFont,
    fontSize = 40,
    onRelease= function()
    end,
}
group.rePlay.x = 200
group.rePlay.y = 240
group:insert(group.rePlay)

group.Home = widget.newButton{
    width = 100,                        --width of the image file(s)
    height = 40,
    label = "Home",
    font  =  native.systemFont,
    fontSize = 40,
    onRelease= function()
    end,
}
group.Home.x = 700
group.Home.y = 240
group:insert(group.Home)


group.Home.alpha = 0
group.Play.alpha = 0
group.rePlay.alpha = 0

classControl.show = function()
    group.alpha = 1
end

classControl.hide = function()
    group.alpha = 0
end
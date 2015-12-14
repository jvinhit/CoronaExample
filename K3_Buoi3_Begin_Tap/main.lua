local txt1 = display.newText("Tren",40,20,nil,40)
txt1.name = "tren"
local txt2 = display.newText("Duoi",40,60,nil,40)
txt2.name = "duoi"
local txt3 = display.newText("Trai",40,100,nil,40)
txt3.name = "trai"
local txt4 = display.newText("Phai",40,140,nil,40)
txt4.name = "phai"
local cir = display.newCircle(400,240,50)
local function func(event)
    if event.target.name == "tren" then
        cir.y = cir.y - 10
    elseif event.target.name == "duoi" then
        cir.y = cir.y + 10
    elseif event.target.name == "trai" then
        cir.x = cir.x - 10
    elseif event.target.name == "phai" then
        cir.x = cir.x + 10
    end
end
txt1:addEventListener("tap",func)
txt2:addEventListener("tap",func)
txt3:addEventListener("tap",func)
txt4:addEventListener("tap",func)
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
   local json = require("json")
   local path = system.pathForFile( "userInfo.json", system.DocumentsDirectory )

   local userInfo = {
      name = "Alfredo",
      surname = "Vilaplana",
      birthdate = "1/1/1980",
      city = "Alcoy"
   }

   local data = json.encode(userInfo)
   local file = io.open( path, "w" )
   
   file:write(data)
   io.close(file)



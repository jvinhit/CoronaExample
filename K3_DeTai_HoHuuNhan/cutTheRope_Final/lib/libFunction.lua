libFunction = {}

--doc va ghi file
local json = require("json")
function libFunction.loadTable(fileName, directory)
    local path = system.pathForFile(fileName,directory)
    local contents = ""
    local myTable = {}
    local file = io.open(path,"r")
    if file then
        --read all contents of life itno a string
        local contents = file:read("*a")
        myTable = json.decode(contents);
        io.close(file)
        return myTable
    end
    return nil
end

function libFunction.saveTable(t,fileName,directory)
    local path = system.pathForFile(fileName,directory)
    local file = io.open(path,"w")
    if file then
        local contents = json.encode(t)
        file:write(contents)
        io.close(file)
        return true
    else
        return false
    end
end


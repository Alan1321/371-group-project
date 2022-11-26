----------------------------------------------------------------------------------
-- How to use
-- first import this file using --> local file = require("file")
-- Call the methods you want ||  
-- To Read --> local data = file.read("data.json")
-- To Write --> file.write("data.json", table) where table is a table variable
----------------------------------------------------------------------------------

local json = require( "json" )
local csv = require("csv")

--reads json file and returns a table
function read(file_name)
    --@params
    --file_name -> name of the json file to read from
    local defaultLocation = system.DocumentsDirectory
    local path = system.pathForFile( file_name, loc )
    local file, errorString = io.open( path, "r" )
    local contents = file:read( "*a" )
    local data = json.decode(contents)

    io.close(file)
    return data
end

--gets a table and writes that to a json file
function write(file_name, t)
    --@params
    --file_name -> name of the json file to read from
    --t -> table which will then be converted and written to json file
    local path = system.pathForFile( file_name, loc )
    local file, errorString = io.open(path, "w")
    file:write( json.encode( t ) )
    io.close(file)
end

return {
    read = read,
    write = write
}
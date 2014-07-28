-- local Net=require"fw.Net"
-- local Host=require"fw.Host"
-- local fw=require"fw"
local rules=require "fw.rules"
local basedir="rules"
local rulelist=rules:list(basedir)
for k,v in pairs(rulelist) do
	print("ruling:",k)
	dofile(basedir .. "/" .. k)
end
local Object=require"fw.Object"
Object:RunPhase("rules")
Object:RunPhase("setup")

io.write("qqq\n")
print(Object:Get("Private"))
io.write("efkef\n")
local IT=require"fw.IT"
IT:printall()

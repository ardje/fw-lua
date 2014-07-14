-- local Net=require"fw.Net"
-- local Host=require"fw.Host"
-- local fw=require"fw"
dofile("rules/services.lua")
dofile("rules/private.lua")
local Object=require"fw.Object"
Object:RunPhase("rules")
Object:RunPhase("setup")

print(Object:Get("Private"))
local IT=require"fw.IT"
IT:printall()

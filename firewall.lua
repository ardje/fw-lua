local Net=require"fw.Net"
local Host=require"fw.Host"
local fw=require"fw"
print("Object net:",Net)
dofile("rules/private.lua")
fw.Object:RunPhase("rules")
fw.Object:RunPhase("setup")
local Object=require"fw.Object"

print(Object:Get("Private"))

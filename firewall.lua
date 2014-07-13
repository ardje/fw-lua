local Net=require"fw.Net"
local Host=require"fw.Host"
local fw=require"fw"
dofile("rules/private.lua")
fw.Object:RunPhase("rules")
fw.Object:RunPhase("setup")

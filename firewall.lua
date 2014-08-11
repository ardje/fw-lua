-- local Net=require"fw.Net"
-- local Host=require"fw.Host"
-- local fw=require"fw"
local log=require"fw.log"
local rules=require "fw.rules"
local ordered=require"fw.ordered"
local basedir="rules"
local rulelist=rules:list(basedir)
for k,v in ordered.pairs(rulelist) do
	log.print("ruling:",k)
	dofile(basedir .. "/" .. k)
end
local Object=require"fw.Object"
Object:RunPhase("setup")
Object:RunPhase("rules")

local IT=require"fw.IT"
IT:printall()

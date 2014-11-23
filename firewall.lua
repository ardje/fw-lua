local log=require"fw.log"
local sandbox=require"fw.sandbox"
local rules=require "fw.rules"
local ordered=require"fw.ordered"
local basedir="rules"
local rulelist=rules:list(basedir)
local shared=sandbox:shared()
for k,v in ordered.pairs(rulelist) do
	log.print("ruling:",k)
	local rule=assert(loadfile(basedir .. "/" .. k,"t",shared))
	rule()
end
local Object=require"fw.Object"
Object:RunPhase("setup")
Object:RunPhase("rules")
Object:RunPhase("rules_end")

local IT=require"fw.IT"
IT:printall()
local IT6=require"fw.IT6"
IT6:printall()

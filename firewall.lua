-- local Net=require"fw.Net"
-- local Host=require"fw.Host"
-- local fw=require"fw"
package.cpath="/usr/local/lib/lua/5.2/?.so;/usr/lib/x86_64-linux-gnu/lua/5.2/?.so;/usr/lib/lua/5.2/?.so;/usr/local/lib/lua/5.2/loadall.so;./?.so;" .. package.cpath
package.path="/usr/local/share/lua/5.2/?.lua;/usr/local/share/lua/5.2/?/init.lua;/usr/local/lib/lua/5.2/?.lua;/usr/local/lib/lua/5.2/?/init.lua;/usr/share/lua/5.2/?.lua;/usr/share/lua/5.2/?/init.lua;./?.lua;"..package.path
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

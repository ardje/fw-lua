require "process.globals"
local log=require"fw.log"
local sandbox=require"fw.sandbox"
local rules=require "fw.rules"
local ordered=require"fw.ordered"
local basedir=rulesdir or "/etc/fw/rules"
local outputdir=scriptsdir or "/var/lib/firewall/scripts"
local output=require"fw.output"
output:outputdir(outputdir)
local rulelist=rules:list(basedir)
--[[
 We first create a shared sandbox env with all important stuff
 Then we create a per file private sandbox with the shared sandbox
 as meta index.
 To create "globals" in the shared sandbox we create a private export
 function with access to the shared sandbox.
-- ]]
local shared=sandbox:shared()
for k,v in ordered.pairs(rulelist) do
  local private=sandbox:private(shared)
  function private.export(...)
    for _,v in pairs{...} do
      if type(v) ~= "string" then
        log.print("export requires strings in "..k)
      else
        shared[v]=private[v]
      end
    end
  end
  log.print("ruling:",k)
  local rule=assert(loadfile(basedir .. "/" .. k,"t",private))
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

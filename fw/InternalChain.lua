local Chain=require"fw.Chain"
local IC=Chain:New("InternalChain")
local function empty()
end
IC.createchain=empty
IC.createchain6=empty
IC.rules=empty
IC.rules_end=empty
local FORWARD=IC:new("FORWARD")
local PREROUTING=IC:new("PREROUTING")
local INPUT=IC:new("INPUT")
INPUT.rules_end=IC._mo.super.rules_end
local OUTPUT=IC:new("OUTPUT")
local POSTROUTING=IC:new("POSTROUTING")
return IC

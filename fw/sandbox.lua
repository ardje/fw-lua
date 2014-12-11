local M={}
M.S={}
local S=M.S
local IC=require"fw.InternalChain"
S.Chain=require"fw.Chain"
S.Net=require"fw.Net"
S.Host=require"fw.Host"
S.Proto=require"fw.Proto"
S.proto=require"fw.protocols"
S.INPUT=Object:Get("INPUT")
S.OUTPUT=Object:Get("OUTPUT")
S.FORWARD=Object:Get("FORWARD")
S.PREROUTING=Object:Get("PREROUTING")
S.POSTROUTING=Object:Get("POSTROUTING")
local posix=require"posix"
S.sysname=posix.uname("%n")
M._meta={ __index=M.S }
function M:shared()
	return self.S
end
function M:private(env)
	local newenv={}
  local meta
  if env ~= nil then
    meta={ __index= env }
  else
    meta=M._meta
  end
	setmetatable(newenv,meta)
  return newenv
end
M._metameta={ __index=_G }
setmetatable(S,M._metameta)

return M


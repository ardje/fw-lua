local M={}
M.S={}
local S=M.S
local IC=require"fw.InternalChain"
S.Object=require"fw.Object"
S.Chain=require"fw.Chain"
S.Net=require"fw.Net"
S.Host=require"fw.Host"
S.ServiceHost=require"fw.ServiceHost"
S.Proto=require"fw.Proto"
S.proto=require"fw.protocols"
S.INPUT=S.Object:Get("INPUT")
S.OUTPUT=S.Object:Get("OUTPUT")
S.FORWARD=S.Object:Get("FORWARD")
S.PREROUTING=S.Object:Get("PREROUTING")
S.POSTROUTING=S.Object:Get("POSTROUTING")
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


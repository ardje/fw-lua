local M={}
M.S={}
local S=M.S
S.Chain=require"fw.Chain"
S.Net=require"fw.Net"
S.Host=require"fw.Host"
S.Proto=require"fw.Proto"
S.proto=require"fw.protocols"
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


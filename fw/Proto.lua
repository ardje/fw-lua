local Object=require"fw.Object"
local M=Object:New("Proto")
function M:asSource()
	return { f=1,"--proto",self.proto,"--source-port",self.port }
end
function M:asDestination()
	return { f=1,"--proto",self.proto,"--destination-port",self.port }
end
M.asDefault=M.asDestination
return M

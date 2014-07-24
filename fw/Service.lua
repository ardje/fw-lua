local Object=require"fw.Object"
local M=Object:New("Service")
function M:asSource()
	return { f=1,self.proto:asSource(),self.host:asSource() }
end
function M:asDestination()
	return { f=1,"--proto",self.proto:asDestination(),self.host:asDestination }
end
M.asDefault=M.asDestination
return M

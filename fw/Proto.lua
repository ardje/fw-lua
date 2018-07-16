local Object=require"fw.Object"
local M=Object:New("Proto")
function M:asSource()
	if self.port then
		return { f=1,"--proto",self.proto,"--source-port",self.port }
	else
		return { f=1,"--proto",self.proto }
	end
end
function M:asDestination()
	if self.port then
		return { f=1,"--proto",self.proto,"--destination-port",self.port }
	else
		return { f=1,"--proto",self.proto }
	end
end
M.asDefault=M.asDestination
return M

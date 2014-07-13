local Object=require"fw.Object"
local M=Object:New("Host")

function M:new(n)
	local o=self.super.new(self,n[1])
	print("Host:new",n[1])
	o.ip=n.ip
	o.net=n.net
	return o
end
function M:allow(...)
	self.net:allow(self:asDestination(),...)
end
function M:asDestination()
	return {"--destination",self.ip}
end
return M

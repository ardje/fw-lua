local Object=require"fw.Object"
local M=Object:New("Host")
local pip=require"fw.parser"

function M:allow(...)
	self:allow4(...)
	self:allow6(...)
end
function M:drop6(...)
	if self.ipv6 ~= nil then
		self.net:drop6{f=1,self:asDestination6(),...}
	end
end
function M:allow6(...)
	if self.ipv6 ~= nil then
		self.net:allow6{f=1,self:asDestination6(),...}
	end
end
function M:drop4(...)
	if self.ip ~= nil then
		self.net:drop{f=1,self:asDestination(),...}
	end
end
function M:allow4(...)
	if self.ip ~= nil then
		self.net:allow{f=1,self:asDestination(),...}
	end
end
function M:asSource6()
	return {f=1,"--source",self.ipv6}
end
function M:asSource()
	return {f=1,"--source",self.ip}
end
function M:asDestination6()
	return {f=1,"--destination",self.ipv6}
end
function M:asDestination()
	return {f=1,"--destination",self.ip}
end
function M:asIP()
	return pip:asIPList(self.ip)
end
function M:asAddress()
	return { self.ip }
end
function M:asAddress6()
	return { self.ipv6 }
end
function M:dnatTo(r)
	local dest=r[1] or r.dest
	local service=r[2] or r.service
	local prerouting=assert(Object:Get("PREROUTING"))
	prerouting:dnat{self,dest,service}
end
M.asDefault=M.asSource
return M

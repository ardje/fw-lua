local Object=require"fw.Object"
local M=Object:New("Host")
local pip=require"fw.parser"

--function M:new(n)
	--local o=self.super.new(self,n[1])
	--print("Host:new",n[1])
	--o.ip=n.ip
	--o.net=n.net
	--return o
--end
function M:allow(...)
	if self.ip ~= nil then
		self.net:allow{f=1,self:asDestination(),...}
	end
	if self.ip6 ~= nil then
		self.net:allow6{f=1,self:asDestination(),...}
	end
end
function M:asSource()
	return {f=1,"--source",self.ip}
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
function M:dnatTo(r)
	dest=r[1] or r.dest
	service=r[2] or r.service
	local prerouting=assert(Object:Get("PREROUTING"))
	prerouting:dnat{self,dest,service}
end
M.asDefault=M.asSource
return M

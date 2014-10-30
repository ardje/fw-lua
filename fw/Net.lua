local Object=require"fw.Object"
local M=Object:New("Net")
local IT=require"fw.IT"
function M:addRule(r)
	local prio=r.prio or 50
	local chain=self:Name()
	local table=r.table or "filter"
	IT:add(table,chain,prio,r)
end
function M:iptables(table,chain,prio,r)
	local prio=prio or 50
	local chain=chain or self:Name()
	local table=table or "filter"
	IT:add(table,chain,prio,r)
end
function M:allow(r)
	self:iptables(nil,nil,r.prio,{f=1,r, "--jump","ACCEPT"})
end
function M:interface(interface)
	if self._interface ~= nil then
		if type(self._interface) == "string" then
			self._interface={ self._interface,interface }
		else
			array.push(self._interface,interface)
		end
	else
		self._interface=interface
	end
	local forward=Object:Get("FORWARD")
	local chain=self:Name()
	forward:iptables(nil,nil,nil,{ f=1,"--out-interface",interface,"--jump",chain} )
end
function M:rules_end()
	if self:Name() ~= "Net" then
		self:iptables(nil,nil,80,{f=1,"--jump","DROP"})
	end
end
function M:dnat(r)
	local from=r[1] or r.from
	local to=r[2] or r.to
	local service=r[3] or r.service
	local rto=to:asAddress()
	if service ~= nil then
		self:iptables("nat",nil,50,{f=1,from:asDestination(),service:asDestination(),"--jump","DNAT","--to",rto})
	else
		self:iptables("nat",nil,50,{f=1,from:asDestination(),"--jump","DNAT","--to",rto})
	end
end
return M

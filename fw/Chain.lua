local Object=require"fw.Object"
local M=Object:New("Chain")
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
	self:addRule{f=1,prio=r.prio,r, "--jump","ACCEPT"}
end
function M:drop(r)
	self:addRule{f=1,prio=r.prio,r, "--jump","DROP"}
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
function M:snat(r)
	local rules=r[1] or r.match
	local to=r[2] or r.to
	local service=r[3] or r.service
	local rto=to:asAddress()
	if service ~= nil then
		self:iptables("nat",nil,50,{f=1,rules,"--jump","SNAT","--to",rto})
	else
		self:iptables("nat",nil,50,{f=1,rules,"--jump","SNAT","--to",rto})
	end
end
function M:rules_end()
	local objects=self:_get("objects")
	if objects == nil then
		self:addRule{f=1,prio=80,"--jump","DROP"}
	end
end

function M:createchain(t)
	io.write("iptables --table ",t," --new-chain ",self:Name(),"\n")
end

function M:flushchain(t)
	io.write("iptables --table ",t," --flush ",self:Name(),"\n")
end
return M



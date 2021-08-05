local Object=require"fw.Object"
local M=Object:New("Chain")
local IT=require"fw.IT"
local IT6=require"fw.IT6"
function M:addRule(r)
	local prio=r.prio or 50
	local chain=self:Name()
	local table=r.table or "filter"
	IT:add(table,chain,prio,r)
end
function M:addRule6(r)
	local prio=r.prio or 50
	local chain=self:Name()
	local table=r.table or "filter"
	IT6:add(table,chain,prio,r)
end
function M:iptables(table,chain,prio,r)
	local prio=prio or 50
	local chain=chain or self:Name()
	local table=table or "filter"
	IT:add(table,chain,prio,r)
end
function M:ip6tables(table,chain,prio,r)
	local prio=prio or 50
	local chain=chain or self:Name()
	local table=table or "filter"
	IT6:add(table,chain,prio,r)
end
function M:allow(r)
	if r.f == nil then
		r.f=1
	end
	self:addRule{f=1,prio=r.prio,table=r.table,r, "--jump","ACCEPT"}
end
function M:allow6(r)
	if r.f == nil then
		r.f=1
	end
	self:addRule6{f=1,prio=r.prio,table=r.table,r, "--jump","ACCEPT"}
end
function M:untrack(r)
	if r.f == nil then
		r.f=1
	end
	self:addRule{f=1,prio=r.prio,table="raw",r, "--jump","CT","--notrack"}
end
function M:untrack6(r)
	if r.f == nil then
		r.f=1
	end
	self:addRule6{f=1,prio=r.prio,table="raw",r, "--jump","CT","--notrack"}
end
function M:drop(r)
	if r.f == nil then
		r.f=1
	end
	self:addRule{f=1,prio=r.prio,r, "--jump","DROP"}
end
function M:drop6(r)
	if r.f == nil then
		r.f=1
	end
	self:addRule6{f=1,prio=r.prio,r, "--jump","DROP"}
end
function M:dnat(r)
	local from=r[1] or r.from
	local to=r[2] or r.to
	local service=r[3] or r.service
	local rto=to:asIP()
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
	local rto=to:asIP()
	if service ~= nil then
		self:iptables("nat",nil,50,{f=1,rules,"--jump","SNAT","--to",rto})
	else
		self:iptables("nat",nil,50,{f=1,rules,"--jump","SNAT","--to",rto})
	end
end
function M:established(r)
	self:addRule{f=1,prio=r,"--match","conntrack","--ctstate","RELATED,ESTABLISHED","--jump","ACCEPT"}
	self:addRule{f=1,prio=r,"--match","conntrack","--ctstate","UNTRACKED","--jump","ACCEPT"}
end
function M:established6(r)
	self:addRule6{f=1,prio=r,"--match","conntrack","--ctstate","RELATED,ESTABLISHED","--jump","ACCEPT"}
	self:addRule6{f=1,prio=r,"--match","conntrack","--ctstate","UNTRACKED","--jump","ACCEPT"}
end
function M:rules_end()
	local objects=self:_get("objects")
	if objects == nil then
		if IT:exists("filter",self:Name()) then
			self:established(80)
			self:addRule{f=1,prio=99,"--jump","DROP"}
		end
		if IT6:exists("filter",self:Name()) then
			self:established6(80)
			self:addRule6{f=1,prio=99,"--jump","DROP"}
		end
	end
end

function M:createchain(io,t)
	io:write("iptables --table ",t," --new-chain ",self:Name(),"\n")
end

function M:flushchain(io,t)
	io:write("iptables --table ",t," --flush ",self:Name(),"\n")
end
function M:createchain6(io,t)
	io:write("ip6tables --table ",t," --new-chain ",self:Name(),"\n")
end

function M:flushchain6(io,t)
	io:write("ip6tables --table ",t," --flush ",self:Name(),"\n")
end

return M



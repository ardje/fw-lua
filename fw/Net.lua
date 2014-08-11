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
return M

local Object=require"fw.Object"
local M=Object:New("Net")
local IT=require"fw.IT"
function M:addRule(r)
	local prio=r.prio or 50
	local chain=self:Name()
	local table=r.table or "filter"
	IT:add(table,chain,prio,r)
end
function M:allow(r)
	self:addRule{r,{ "--jump","ACCEPT"}}
end
return M

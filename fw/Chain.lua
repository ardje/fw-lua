local Object=require"fw.Object"
local M=Object:New("Chain")
function M:New(p)
	local o
	o=self:_new(p)
	self.table=o.filter
	self.chain=o.chain
end
function M:allow(...)
	print("Chain allow:",...)
	--self:addRule(...)
end
return M


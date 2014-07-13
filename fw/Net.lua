local Object=require"fw.Object"
local M=Object:New("Net")
function M:allow(...)
	print(...)
	--self:addRule(...)
end
return M

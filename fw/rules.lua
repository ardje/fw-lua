local M={}
local posix=require"posix"

function M:list(aDir)
	local l={}
	for f in posix.files(aDir) do
		local ps=posix.stat(aDir .. "/" .. f)
		if ps ~= nil and ps.type ~= directory and f:match("^%w") then
			l[f]=1
		end
	end
	return l
end
return M

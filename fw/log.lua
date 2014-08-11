local M={}
local stderr=io.stderr

function M.print(...)
	for _,v in ipairs(table.pack(...)) do
		--print(v)
		if type(v) ~= "string" then
			v=tostring(v)
		end
		stderr:write(v)
	end
	stderr:write("\n")
end

return M

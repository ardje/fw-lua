local host=require"fw.Host"
local M=host:New{"ServiceHost"}
function M:Service{r}
	local source=r[1]
	for n=2,#r do
		local aservice=r[n]
		source:allow{aservice}
		self:dnatTo{source,aservice}
	end
end
function M:DNatMe{r}
	local source=r[1]
	for n=2,#r do
		local aservice=r[n]
		self:dnatTo{source,aservice}
	end
end
return M

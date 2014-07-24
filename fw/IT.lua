Object=require"fw.Object"
local dh=require"dumphash"
local e=require"fw.expand"
local M=Object:New(IT)
M._tables={}

function M:add(t,c,p,r)
	self._tables[t]=self._tables[t] or {}
	self._tables[t][c]=self._tables[t][c] or {}
	self._tables[t][c][p]=self._tables[t][c][p] or {}
	local n=self._tables[t][c][p]
	n[#n+1]=r
end

function M:printchain(t,c)
	local o={}
 	for n in pairs(self._tables[t][c]) do o[#o+1]=n end	
	table.sort(o)
	for _,n in ipairs(o) do
		for prio,aRule in ipairs(self._tables[t][c][n]) do
			local lines=e.expand(aRule)
			e.dt(lines)
		end
	end
end
function M:printall()
	for t in pairs(self._tables) do
		for c in pairs(self._tables[t]) do
			self:printchain(t,c)
		end
	end	
end

return M

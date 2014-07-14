Object=require"fw.Object"
local M=Object:New(IT)
M._tables={}

function M:add(t,c,p,r)
	self._tables[t]=self._tables[t] or {}
	self._tables[t][c]=self._tables[t][c] or {}
	self._tables[t][c][p]=self._tables[t][c][p] or {}
	local n=self._tables[t][c][p]
	n[#n+1]=r
end

function M.printrule(r,e)
function M:printrule(r,e)
	local e=e or {}
	for _,n in pairs(r) do
		if type(n) == "table" then
			if getmetatable(n) == nil then
				self:printrule(n,e)
			else
				o=n:asRules()
			end
		elseif type(n)=="string" then
			e[#e+1]=n	
		end
	end
	print(table.unpack(e))
	return e
end
function M:printchain(t,c)
	local o={}
	for n in pairs(self._tables[t][c]) do o[#o+1]=n end	
	table.sort(o)
	for _,n in ipairs(o) do
		self:printrule(self._tables[t][c][n])
	end
end
function M:printall()
	for t in pairs(self._tables) do
		for c in pairs(self._tables[t]) do
			self.printchain(t,c)
		end
	end	
end

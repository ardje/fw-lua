Object=require"fw.Object"
local dh=require"dumphash"
local M=Object:New(IT)
M._tables={}

function M:add(t,c,p,r)
	self._tables[t]=self._tables[t] or {}
	self._tables[t][c]=self._tables[t][c] or {}
	self._tables[t][c][p]=self._tables[t][c][p] or {}
	local n=self._tables[t][c][p]
	n[#n+1]=r
end

local function additemline(items)
	local itemline={}
	if #items > 0 then
		for _,item in ipairs(items[1]) do
			itemline[#itemline+1]=item
		end
	end
	items[#items+1]=itemline
end
local function additem(items,item)
	for _,l in ipairs(items) do
		l[#l+1]=item
	end
end
local function addtable(items,item)
	for _,n in pairs(item) do
		if type(n) == "string" then
			additem(items,n)
		elseif type(n) == "table" then
			if getmetatable(n) == nil then
				additemline(items)
				addtable(items,n)
			else
				local o=n:asRules()
				if type(o) == "string" then
					additem(items,o)
				else
					addtable(items,o)
				end
			end
		end
	end
end
function M:printrule(r,items)
	local items=items or {}
	dh.dumphash(r)
	additemline(items)
	addtable(items,r)
	dh.dumphash(items)
	return items
end
function M:printchain(t,c)
	local o={}
 	for n in pairs(self._tables[t][c]) do o[#o+1]=n end	
	table.sort(o)
	for _,n in ipairs(o) do
		for prio,aRule in ipairs(self._tables[t][c][n]) do
			local lines=self:printrule(aRule)
			print ("Expanded chain:")
			for _,l in ipairs(lines) do
				print(t,c,table.unpack(l))
			end
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

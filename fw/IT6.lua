Object=require"fw.Object"
local ordered=require"fw.ordered"
--local dh=require"dumphash"
local e=require"fw.expand"
local M=Object:New("IT6")
local output=require"fw.output"
M._tables={}

--[[
	Datastructure:
	_tables->filter,mangle,nat->chainname->prio->rules

]]
function M:add(t,c,p,r)
	self._tables[t]=self._tables[t] or {}
	self._tables[t][c]=self._tables[t][c] or {}
	self._tables[t][c][p]=self._tables[t][c][p] or {}
	local n=self._tables[t][c][p]
	n[#n+1]=r
end

function M:createchain(t,c)
	local chainobject=Object:Get(c)
	if chainobject ~= nil then
		local io=output:output{proto="ipv6",stage="create",table=t,name=c}
		chainobject:createchain6(io,t)
	else
		io.stderr:write("Skipping createchain"..c.."\n")
	end
end

function M:flushchain(t,c)
	local io=output:output{proto="ipv6",stage="flush",table=t,name=c}
	local chainobject=Object:Get(c)
	io:write("ip6tables --table ",t," --flush ",chainobject:Name(),"\n")
end

function M:printchain(t,c)
	--local chainobject=Object:Get(c)
	local io=output:output{proto="ipv6",stage="rules",table=t,name=c}
	for prio,rules in ordered.pairs(self._tables[t][c]) do
		--io.write("Dumping lines for ",t," ",c,"\n")
		--chainobject:ip6tables_start(t)
		for _,aRule in ipairs(rules) do
			local lines=e.expand(aRule)
			e.dt(io,lines,{"ip6tables","--table",t,"--append",c})
		end
	end
end
function M:printall()
	for t in ordered.pairs(self._tables) do
		for c in ordered.pairs(self._tables[t]) do
			self:createchain(t,c)
		end
		for c in ordered.pairs(self._tables[t]) do
			self:flushchain(t,c)
		end
		for c in ordered.pairs(self._tables[t]) do
			self:printchain(t,c)
		end
	end	
end

return M

local M={}
local function createIndex(t,ordering)
	local i={}
	for k,_ in pairs(t) do
		i[#i+1]=k
	end
	table.sort(i,ordering)
	return i
end

local function orderedNext(t,state)
	local index=t.index or 0
	if t.ordered==nil then
		t.ordered=createIndex(t.table)
	end
	if index < #t.ordered then
		index=index+1
		local v=t.ordered[index]
		t.index=index
		return v, t.table[v]
	end
	return nil
end

function M.pairs(t,ordering)
	return orderedNext,{table=t,ordering=ordering},nil
end

--[[ test code

local q={
	Abracadabra = 1,
	poep=4,
	lalala=8,
	zucht=1,
	kwaak=4
}
for k,v in M.pairs(q) do
	print(k,v)
end
-- ]]
return M

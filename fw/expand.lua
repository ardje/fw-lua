local M={}
local dh=require"dumphash"

--local dh={ dumphash=function() end }
local function explode(l,r)
	local nl=#l
	local nr=#r
	if nl == 0 then
		l[#l+1]={}
		nl=#l
	end
	local ll={}
	for i = 1,nr do
		for j = 1,nl do
			local tl
			if i==1 then
				tl=l[j]
				ll[j]= ll[j] or #l[j]
			else
				local offset=(i-1)*nl
				tl={}
				l[j+offset]=tl
				for k = 1,ll[j] do
					tl[#tl+1]=l[j][k]
				end
			end
			for _,v in ipairs(r[i]) do
				tl[#tl+1]=v
			end
		end
	end
	return l
end
local function expand(r,depth)
	if getmetatable(r) ~= nil then
		print("got metatable, evaluating")
		return expand(r:asDefault(),depth+1)
	end
	depth=depth or 1
	local items
--[[
	print("depth:",depth)
	print("r")
	dh.dumphash(r)
	print("items")
	dh.dumphash(items)
]]
	if r.f~=nil then
		items={{}}
		print "flattening"
		for k,v in ipairs(r) do
			if type(v) == "table" then
				local rr=expand(v,depth+1)
				print("now depth:",depth)
				print("explode items") dh.dumphash(items)
				print("with rr") dh.dumphash(rr)
				explode(items,rr)
			else
				for ik,iv in ipairs(items) do
					iv[#iv+1]=v
				end
			end
		end
	else
		items={}
		print "exploding"
		for k,v in ipairs(r) do
			if type(v) == "table" then
				local rr=expand(v,depth+1)
				print("now depth:",depth)
				for k,v in ipairs(rr) do
					items[#items+1]=v
				end
			else
				--explode(items,{ { v } } )
				items[#items+1]={v}
			end
		end
		print("exploded items:")
		dh.dumphash(items)
		print("---------------")
	end
	return items
end
local function dt(t)
	print("table rule dump")
	for _,v in pairs(t) do
		print(table.unpack(v))
	end
end
M.dt=dt
M.expand=expand
M.explode=explode
return M
--[=[
-- [[
l=expand{ flatten = 1, { flatten = 1, "iptables", "--table" , "filter","--append",chainname } , { flatten = 1, "--proto",{ explode = 1 ,"tcp","udp" },"--destination-port",{ explode = 1,"8080","8081", { "zomaar" ,"wat" } } },{ flatten=1,"--jump","ACCEPT" } }
print("result")
--dh.dumphash(l)
dt(l)
os.exit(0)
-- ]]
l=explode({
	{}
},{
	{ "iptables","-A","mychain","--proto","udp"},
	{ "iptables","-A","mychain","--proto","tcp"}
})
-- dh.dumphash(l)
dt(l)
l=explode({
	{ "iptables","-A","mychain","--proto","udp"},
	{ "iptables","-A","mychain","--proto","tcp"}
},{
})
--dh.dumphash(l)
dt(l)
l=explode({
	{ "iptables","-A","mychain","--proto","udp"},
	{ "iptables","-A","mychain","--proto","tcp"}
},{
	{"8080"},
	{"8081"}
})
--l=explode({{ "iptables","-A","mychain","--proto"}},{{"udp"},{"tcp"}})
dt(l)
--dh.dumphash(l)
--expand(nil,nil,{"doiptables","--source", "tcp",{ "50","51"} })
--expand(nil,nil,{"doiptables","--source",{{ "tcp", "50"},{"tcp","51"}} })
--expand(nil,nil,{"doiptables","--source",{ "A","B",{"C","D"} },{"123.123.123.123/24","32.32.32.32/24"},"poep"})
--expand(nil,nil,...)
--[[
for i = 1,10000 do
expand(nil,nil,"doiptables","--source","(A^B)","([0]=123.123.123.123/24^[1]=32.32.32.32/24)","poep")
end
-- ]]
-- ]=]

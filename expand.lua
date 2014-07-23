local dh=require"dumphash"
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
function expand(items,line,base,r)
	items=items or {}
	line=line or {}
	base=base or 0
	local max=#r
	local i=1
	print("r")
	dh.dumphash(r)
	print("l")
	dh.dumphash(line)
	for k,v in pairs(r) do
		if type(v) == "table" then
			-- Arrays do not print, arrays recurse
			print("recurse table",base+i+1)
			r[k]=expand(line,base+i+1,v)
		else
			line[i+base]=v
			-- end of the line: we must print it
			if i+1 == max
			then
				print("io.write")
				dh.dumphash(line)
				--io.write(table.concat(line," "),"\n")
				--io.write(line,"\n")
			end
		end
			i=i+1
	end
	print("dh line",base,i)
	dh.dumphash(line)
end
expand{ flatten = 1, { flatten = 1, "iptables", "--table" , "filter","--append",chainname } , { flatten = 1, "--proto",{ explode = 1 ,"tcp","udp" },"--destination-port",{ explode = 1,"8080","8081" } },{ flatten=1,"--jump","ACCEPT" } }
--expand(nil,nil,{"doiptables","--source", "tcp",{ "50","51"} })
--expand(nil,nil,{"doiptables","--source",{{ "tcp", "50"},{"tcp","51"}} })
--expand(nil,nil,{"doiptables","--source",{ "A","B",{"C","D"} },{"123.123.123.123/24","32.32.32.32/24"},"poep"})
--expand(nil,nil,...)
--[[
for i = 1,10000 do
expand(nil,nil,"doiptables","--source","(A^B)","([0]=123.123.123.123/24^[1]=32.32.32.32/24)","poep")
end
-- ]]

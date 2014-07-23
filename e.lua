function expand(line,base,...)
	line=line or {}
	base=base or 1
	local max=select("#",...)
	for i=base, max do
		local v=select(i,...)
		if v:find("^%(")
		then
			-- Arrays do not print, arrays recurse
			local array=v:match("%(([^)]+)%)")
			for element in array:gmatch("([^^=]+)[^=]?") do
				if element:find("^%[") == nil then
					line[i]=element;
					expand(line,i+1,...)
				end
			end
			return
		else
			line[i]=v
			-- end of the line: we must print it
			if i == max
			then
				io.write(table.concat(line," "),"\n")
				--io.write(line,"\n")
			end
		end
	end
end
expand(nil,nil,"doiptables","--source","(A^B^(C^D))","(tcp(50^51)^udp(50^52)","([0]=123.123.123.123/24^[1]=32.32.32.32/24)","poep")
--expand(nil,nil,...)
--[[
for i = 1,10000 do
expand(nil,nil,"doiptables","--source","(A^B)","([0]=123.123.123.123/24^[1]=32.32.32.32/24)","poep")
end
-- ]]

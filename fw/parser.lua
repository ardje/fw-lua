local M = {}
function M:checkip(ip)
        local d={}
	local mask
        d[1],d[2],d[3],d[4],mask=string.match(ip,"(%d+).(%d+).(%d+).(%d+)/(%d+)")
        if mask == nil
        then
                mask=32
                d[1],d[2],d[3],d[4]=string.match(ip,"(%d+).(%d+).(%d+).(%d+)")
        end
        if d[4]==nil
        then
                return nil
        end
        if mask then
                mask=tonumber(mask)
                if mask >32 or mask <0
                then
                        mask=nil
                end
        end
        for k,v in pairs(d)
        do
                local n=tonumber(v)   
                if n<0 or n>255
                then
                        return nil
                end
                d[k]=n
        end
        return d[1],d[2],d[3],d[4],mask
end
function M:asIP(ip)
	local q1,q2,q3,q4,mask=M:checkip(ip)
	if q1 == nil then
		return nil
	else	
		return { string.format("%d.%d.%d.%d",q1,q2,q3,q4) }
	end
end
function M:asIPList(ip)
	if type(ip) == "string" then
		return M:asIP(ip)
	else
		local list={}
		for k,v in ipairs(ip) do
			list[#list+1]=M:asIP(v)
		end
		return list
	end
end
return M

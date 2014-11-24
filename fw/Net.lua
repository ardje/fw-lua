local Object=require"fw.Object"
local Chain=require"fw.Chain"
local M=Chain:New("Net")
local pip=require"fw.parser"
function M:interface(interface)
	if self._interface ~= nil then
		if type(self._interface) == "string" then
			self._interface={ self._interface,interface }
		else
			array.push(self._interface,interface)
		end
	else
		self._interface=interface
	end
	local forward=Object:Get("FORWARD")
	local chain=self:Name()
	if self.ip ~= nil then
		forward:iptables(nil,nil,nil,{ f=1,"--out-interface",interface,"--jump",chain} )
	end
	if self.ipv6 ~= nil then
		forward:ip6tables(nil,nil,nil,{ f=1,"--out-interface",interface,"--jump",chain} )
	end
end
function M:rules_end()
	local objects=self:_get("objects")
	if objects == nil then
		if self.ip ~= nil then
			self:established(80)
			self:addRule{f=1,prio=99,"--jump","DROP"}
		end
		if self.ipv6 ~= nil then
			self:established6(80)
			self:addRule6{f=1,prio=99,"--jump","DROP"}
		end
	end
end
function M:asDestination()
	return { f=1,"--out-interface",self._interface }

end
function M:asSource()
	return { f=1,"--in-interface",self._interface }

end
function M:asAddress()
	return self.ip
end
function M:asIP()
	return pip:asIPList(self.ip)
end
function M:asSourceIP()
	return { f=1,"--source",self:asAddress() }
end
function M:asDestinationIP()
	return { f=1,"--destination",self:asAddress() }
end
M.asDefault=M.asSource
	
return M

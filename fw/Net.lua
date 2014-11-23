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
	forward:iptables(nil,nil,nil,{ f=1,"--out-interface",interface,"--jump",chain} )
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

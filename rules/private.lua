local Net=require"fw.Net"
local Host=require"fw.Host"
local Service=require"fw.Service"
local ssh=Service:Get("ssh")

local private=Net:new("Private")
function private:rules()
	self:allow{"test"}
end
local shell3=Host:new{"Shell3",ip={"192.168.0.44/32","192.168.0.55/32"},net=private}
function shell3:rules()
	self:allow{ssh}
end

Net:New("testclass")

local Net=require"fw.Net"
local Host=require"fw.Host"
local service=require"fw.Service"
local ssh=Service:Get("ssh")
Net:new("Private")
function Private:rules()
	self:allow("test")
end
Host:new{"Shell3",ip="192.168.0.44/32",net=Private}
function Shell3:rules()
	self:allow(ssh)
end


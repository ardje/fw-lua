local Net=require"fw.Net"
local Host=require"fw.Host"
print("Object Net:",Net)
Net:new("Private")
function Private:rules()
	self:allow("test")
end
-- Private:rules()
Host:new{"Shell3",ip="192.168.0.44/32",net=Private}
function Shell3:rules()
	self:allow("blap")
end
print("Print an object",Shell3,Shell3:__tostring())
print(fw.Host:ClassName())
-- fw.Host:New("Shell3")


fw=require"fw.init"

fw.Net:new("Private")
function Private:rules()
	self:allow("test")
end
-- Private:rules()
fw.Host:new{"Shell3",ip="192.168.0.44/32",net=Private}
function Shell3:rules()
	self:allow("blap")
end
print("Print an object",Shell3,Shell3:__tostring())
print(fw.Host:ClassName())
fw.Object:RunPhase("rules")
fw.Object:RunPhase("setup")
-- fw.Host:New("Shell3")


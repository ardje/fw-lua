local Net=require"fw.Net"
local Host=require"fw.Host"
local Proto=require"fw.Proto"

local ssh=Proto:Get("ssh")

local private=Net:new("Private")
function private:rules()
end

local shell3=Host:new{"Shell3",ip={"192.168.0.44/32"},net=private}
function shell3:rules()
	self:allow{ssh}
end

local ast2=Host:new{"Ast2",ip={"192.168.0.11/32"},net=private}
function ast2:rules()
	self:allow{Proto:Get("sip")}
	self:allow{Proto:Get("iax2")}
	self:allow{Proto:Get("dundi")}
end


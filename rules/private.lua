local Net=require"fw.Net"
local Host=require"fw.Host"
local Proto=require"fw.Proto"
local proto=require"fw.protocols"

local private=Net:new("Private")
function private:rules()
end

local shell3=Host:new{"Shell3",ip={"192.168.0.44/32"},net=private}
function shell3:rules()
	self:allow{proto.ssh}
end

local rtprange=Proto:New{"ast2rtprange",proto="udp",port="10000:20000"}
local ast2=Host:new{"Ast2",ip={"192.168.0.11/32"},net=private}
function ast2:rules()
	self:allow{proto.sip}
	self:allow{proto.iax2}
	self:allow{proto.dundi}
	self:allow{rtprange}
end


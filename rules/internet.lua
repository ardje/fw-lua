local Net=require"fw.Net"
local Host=require"fw.Host"
local Proto=require"fw.Proto"
local proto=require"fw.protocols"

local publicip=Host:new{"PublicIP",ip={"84.245.27.153/32"}}

local internet=Net:new("Internet")
internet:interface("fw-vlan34")

function internet:SNatMe(source)
	local POSTROUTING=Object:Get("POSTROUTING")
	POSTROUTING:snat{{f=1,self:asDestination(),source:asSourceIP()},publicip}
end

function internet:rules()
end

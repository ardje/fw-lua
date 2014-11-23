local publicip=Host:new{"PublicIP",ip={"84.245.6.101/32"}}

local internet=Net:new{"Internet",ip={}}
internet:interface("fw1-vlan34")

function internet:SNatMe(source)
	local POSTROUTING=Object:Get("POSTROUTING")
	POSTROUTING:snat{{f=1,self:asDestination(),source:asSourceIP()},publicip}
end


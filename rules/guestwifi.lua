local guestwifi=Net:new{"GuestWifi",ip={"192.168.9.2/24"},ipv6={"2001:7b8:32d:0::/64"}}
guestwifi:interface("fw1-vlan5")

function guestwifi:rules()
	local private=Object:Get("Private")
	local internet=Object:Get("Internet")
	internet:SNatMe(self)
	private:SNatMe(self)
	internet:drop{self,proto.smtp}
	internet:allow{self}
end

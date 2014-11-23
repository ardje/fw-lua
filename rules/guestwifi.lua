local Net=require"fw.Net"
local Host=require"fw.Host"
local Proto=require"fw.Proto"
local proto=require"fw.protocols"

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


--[[
                generic_forwarding ${IFWIFI}
                iptables --table filter --append wireless --in-interface ${IFLAN} --jump ACCEPT
                iptables --table filter --append wireless --in-interface ${IFWAN1} --source ! 10.0.0.0/8 --jump ACCEPT
                #iptables --table filter --append wireless --in-interface ${IFWAN2} --source ! 172.19.3.1/32 --jump ACCEPT
                iptables --table filter --append input_rule --in-interface ${IFWIFI} --proto udp --destination-port 67 --jump ACCEPT
                iptables --table filter --append input_rule --in-interface ${IFWIFI} --proto udp --destination-port 68 --jump ACCEPT
                allow6
                ;;
-- ]]

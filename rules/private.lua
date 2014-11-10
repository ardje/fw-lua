local Net=require"fw.Net"
local Host=require"fw.Host"
local Proto=require"fw.Proto"
local proto=require"fw.protocols"

local private=Net:new{"Private",ip={"192.168.0.2/24"}}
private:interface("fw-vlan1")

function private:rules()
	local internet=Object:Get("Internet")
	internet:SNatMe(self)
end

local function PublicService(self, ...)
	local publicip=Object:Get("PublicIP")
	for _,aservice in ipairs{...} do
		self:allow{aservice}
		publicip:dnatTo{self,aservice}
	end
end

local shell3=Host:new{"Shell3",ip={"192.168.0.44/32"},net=private}
function shell3:rules()
	PublicService(self,proto.ssh)
end

local rtprange=Proto:New{"ast2rtprange",proto="udp",port="10000:20000"}
local ast2=Host:new{"Ast2",ip={"192.168.0.11/32"},net=private}
function ast2:rules()
	PublicService(self,proto.sip,proto.iax2,proto.dundi,rtprange)
end

local mail1=Host:new{"Mail1",ip={"192.168.0.250/32"},net=private}
function mail1:rules()
	PublicService(self,proto.smtp)
end
local nameserver1=Host:new{"Nameserver1",ip={"192.168.0.64/32"},net=private}
function nameserver1:rules()
	PublicService(self,proto.dns)
end
local haproxy=Host:new{"Haproxy",ip={"192.168.0.69/32"},net=private}
function haproxy:rules()
	PublicService(self,proto.http,proto.https)
end

--[[
        rules)
                generic_forwarding ${IFLAN}
                iptables --table filter --append private --in-interface ${IFLAN} --jump ACCEPT
                # DNS publiek
                dnatAPPA ${MY_WAN_IP} udp 53 192.168.0.64
                dnatAPPA ${MY_WAN_IP} tcp 53 192.168.0.64
##              dnatAPPA ${MY_WAN_IP} tcp 51413 192.168.0.136
                dnatAPPA 192.168.1.34 udp 123 192.168.0.102
--                allow --proto tcp --dport 53 --destination 192.168.0.64/31
--                allow --proto udp --dport 53 --destination 192.168.0.64/31
--                allow --proto tcp --dport 53 --destination 192.168.0.96/31
--                allow --proto udp --dport 53 --destination 192.168.0.96/31
                # IMAPS
                allow --proto tcp --dport 993 --destination 192.168.0.39/32
                #allow --proto udp --dport 123 --destination 192.168.0.102/32
                allow --proto udp --dport 123 --destination 192.168.0.100/32
                # dreambox
                for anIp in 178.33.60.14 199.204.248.102
                do
                        drop --source $anIp
                done
                drop --source 69.64.32.0/19 --destination 192.168.0.10

                # SSMTP
                allow --proto tcp --dport 25 --destination 192.168.0.35/32
                iptables --table nat --append prerouting_rule --destination ${MY_WAN_IP} --proto tcp --dport 22 --jump DNAT --to-destination  192.168.0.242
                dnatAPPA ${MY_WAN_IP} udp 10000:20000 192.168.0.11
                dnatAPPA ${MY_WAN_IP} udp 5060 192.168.0.11
                dnatAPPA ${MY_WAN_IP} udp 4569 192.168.0.11
                dnatAPPA ${MY_WAN_IP} udp 4520 192.168.0.11

                # EMAIL
                dnatAPPA ${MY_WAN_IP} tcp 25 192.168.0.250
                # OUDE WEBSITES
                dnatAPPA ${MY_WAN_IP} tcp 80 192.168.0.69
                # SSL
                dnatAPPA ${MY_WAN_IP} tcp 443 192.168.0.69
                allow --in-interface $IFWIFI --proto udp --dport 67
                allow --in-interface $IFWIFI --proto udp --dport 68
                allow6 --proto icmp
                allow6 --proto icmpv6
                allow6 --proto tcp --dport 22 --source 2a02:310:0:1012::/64
                allow6 --proto tcp --dport 22 --source 2a02:310:0:1013::/64
                allow6 --proto tcp --dport 22 --source 2a02:10:100::209/128
                allow6 --proto tcp --dport 22 --source 2001:7b8:32d::/60
                allow6 --proto tcp --dport 22 --source 2001:7f8:13::a500:5418:1/128
                allow6 --proto tcp --dport 25 --destination 2001:7b8:32d::4
                allow6 --proto tcp --dport 80 --destination 2001:7b8:32d::0/124
                drop6 --proto tcp --dport 2049 --destination 2001:7b8:32d::0/64
                drop6 --proto udp --dport 2049 --destination 2001:7b8:32d::0/64
                allow6 --proto tcp --dport 51434 --destination 2001:7b8:32d:0:224:1dff:fe7f:4088
                allow6 --proto tcp  ! --syn --dport 1024:65535 --destination 2001:7b8:32d::0/64
                allow6 --proto udp --dport 1024:65535 --destination 2001:7b8:32d::0/64
                iptables --table filter --append input_rule --in-interface ${IFLAN} --jump ACCEPT
                ;;
-- ]]

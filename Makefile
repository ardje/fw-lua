ALL: iptables.sh

iptables.sh: rules/* fw/* firewall.lua
	lua firewall.lua > iptables.sh

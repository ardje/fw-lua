ALL: iptables.log

iptables.log: rules/* /etc/fw/rules/* fw/* firewall.lua Makefile
	-rm /var/lib/firewall/scripts/*/*
	lua firewall.lua
	-diff -ruN /var/lib/firewall/scripts.applied /var/lib/firewall/scripts

apply: /var/lib/firewall/scripts/*
	./applyscripts
	-rm -fr /var/lib/firewall/scripts.applied	
	-mv /var/lib/firewall/scripts /var/lib/firewall/scripts.applied

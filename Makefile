ALL: iptables.log

iptables.log: rules/* fw/* firewall.lua Makefile
	-mkdir -p scripts/ipv4 scripts/ipv6
	-rm scripts/*/*
	lua firewall.lua 2> iptables.log
	-diff -ruN scripts.applied scripts

apply: scripts/*
	./applyscripts
	-rm -fr scripts.applied	
	-mv scripts scripts.applied

ALL: iptables.log

iptables.log: rules/* fw/* firewall.lua
	-mkdir scripts
	-rm scripts/*
	lua firewall.lua > iptables.log
	-diff -ruN scripts.old scripts

apply: scripts/*
	./applyscripts
	-rm -fr scripts.old	
	-mv scripts scripts.old

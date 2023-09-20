local s=require"fw.Proto"
return {
	ssh=s:new{"ssh",proto="tcp",port=22},
	http=s:new{"http",proto="tcp",port=80},
	https=s:new{"https",proto="tcp",port=443},
	httpalt=s:new{"httpalt",proto="tcp",port=8080},
	sip=s:new{"sip",proto={"tcp","udp"},port=5060},
	iax2=s:new{"iax2",proto="udp",port=4569},
	dundi=s:new{"dundi",proto="udp",port=4520},
	smtp=s:new{"smtp",proto="tcp",port=25},
	smtps=s:new{"smtps",proto="tcp",port=465},
	dns=s:new{"dns",proto={"tcp","udp"},port=53},
	bootps=s:new{"bootps",proto={"udp"},port=67},
	bootpc=s:new{"bootpc",proto={"udp"},port=68},
	squid=s:new{"squid",proto={"tcp"},port=3128},
	ntp=s:new{"ntp",proto={"udp"},port=123},
	rdp=s:new{"rdp",proto={"tcp"},port=3389},
	svn=s:new{"svn",proto={"tcp"},port=3690},
	rsync=s:new{"rsync",proto={"tcp"},port=873},
	syslog=s:new{"syslog",proto={"udp"},port=514},
	ipp=s:new{"ipp",proto={"tcp"},port=631},
	bitcoin=s:new{"bitcoin",proto={"tcp"},port=8333},
	bitcointest=s:new{"bitcointest",proto={"tcp"},port=18333},
	imaps=s:new{"imaps",proto={"tcp"},port=993},
	smtpsubmission=s:new{"smtpsubmission",proto={"tcp"},port=587},
	nrpe=s:new{"nrpe",proto={"tcp"},port=5666},
	icinga=s:new{"icinga",proto={"tcp"},port=5665},
	varnish=s:new{"varnish",proto={"tcp"},port=6081},
	icmp=s:new{"icmp",proto={"icmp"}},
	icmp6=s:new{"icmp6",proto={"icmpv6"}},
	influxhttp=s:new{"influxhttp",proto="tcp",port=8086},
	snmp=s:new{"snmpt",proto={"udp","tcp"},port=161},
	snmptrap=s:new{"snmptrap",proto={"udp","tcp"},port=162},
	openvpntcp=s:new{"openvpntcp",proto={"tcp"},port=1194},
	openvpnudp=s:new{"openvpnudp",proto={"udp"},port=1194},
	wireguard=s:new{"wireguard",proto={"udp"},port=51820},
	mssql=s:new{"mssql",proto={"tcp"},port=1433},
	mqtt=s:new{"mqtt",proto={"tcp"},port=1883},
	vnc=s:new{"vnc",proto={"tcp"},port=5900},
	isakmp=s:new{"isakmp",proto={"udp"},port=500},
	ipsecnatt=s:new{"ipsecnatt",proto={"udp"},port=4500},
	ldap=s:new{"ldap",proto={"tcp"},port=389},
	ldaps=s:new{"ldaps",proto={"tcp"},port=636},
	pveapi=s:new{"pveapi",proto={"tcp"},port=8006},
	radosgw=s:new{"radosgw",proto={"tcp"},port=7480},
	babel=s:new{"babel",proto={"udp"},port=6696},
}

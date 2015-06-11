local s=require"fw.Proto"
return {
	ssh=s:new{"ssh",proto="tcp",port=22},
	http=s:new{"http",proto="tcp",port=80},
	https=s:new{"https",proto="tcp",port=443},
	sip=s:new{"sip",proto={"tcp","udp"},port=5060},
	iax2=s:new{"iax2",proto="udp",port=4569},
	dundi=s:new{"dundi",proto="udp",port=4520},
	smtp=s:new{"smtp",proto="tcp",port=25},
	dns=s:new{"dns",proto={"tcp","udp"},port=53},
	bootps=s:new{"bootps",proto={"udp"},port=67},
	bootpc=s:new{"bootpc",proto={"udp"},port=68},
	squid=s:new{"squid",proto={"tcp"},port=3128},
	ntp=s:new{"ntp",proto={"udp"},port=123},
	rdp=s:new{"rdp",proto={"tcp"},port=3389}
	svn=s:new{"svn",proto={"tcp"},port=3690}
}

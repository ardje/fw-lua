local s=require"fw.Proto"
return {
	ssh=s:new{"ssh",proto="tcp",port=22},
	http=s:new{"http",proto="tcp",port=80},
	https=s:new{"https",proto="tcp",port=443},
	sip=s:new{"sip",proto={"tcp","udp"},port=5060},
	iax2=s:new{"iax2",proto="udp",port=4569},
	dundi=s:new{"dundi",proto="udp",port=4520}
}

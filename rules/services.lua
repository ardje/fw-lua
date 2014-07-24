local s=require"fw.Proto"

s:new{"ssh",proto="tcp",port=22}
s:new{"http",proto="tcp",port=80}
s:new{"https",proto="tcp",port=443}
s:new{"sip",proto={"tcp","udp"},port=5060}

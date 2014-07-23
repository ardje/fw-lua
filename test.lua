local dh=require"dumphash"
local m={ flatten = 1, { flatten = 1, "iptables", "--table" , "filter","--append",chainname } , { flatten = 1, "--proto",{ explode = 1 ,"tcp","udp" },"--destination-port",{ explode = 1,"8080","8081" } },{ flatten=1,"--jump","ACCEPT" } }
dh.dumphash(m)
local m={ flatten = 1, { flatten = 1, "iptables", "--table" , "filter","--append",chainname } , { flatten = 1, "--proto",{ explode = 1 ,"tcp","udp" },"--destination-port",{ explode = 1,"8080","8081" } },{ flatten=1,"--jump","ACCEPT" } }

local l={ flatten = 1, { flatten = 1, "iptables", "--table" , "filter","--append",chainname } , { flatten = 1, "--proto",{ explode = 1 ,"tcp","udp" },"--destination-port",{ explode = 1,"8080","8081" } },{ flatten=1,"--jump","ACCEPT" } }
{} s=1 n=2 
{ "iptables","--table","--filter","--append",naam

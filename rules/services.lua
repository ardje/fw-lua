local s=require"fw.Service"

s:new{"ssh",proto="tcp",port=22}
s:new{"http",proto="tcp",port=80}

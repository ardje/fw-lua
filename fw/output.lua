local M={}
M._basedir="scripts"
M._filedescriptor={}
M._filename={}
local posix=require"posix"
M._stages={ create="10-create",rules="60-rules",flush="20-flush" }
function M:outputdir(n)
  M._basedir=n
end
function M:outputkey(r)
	local key=string.format("%s/%s-%s-%s",r.proto,self._stages[r.stage],r.table,r.name)
	local filename=string.format("%s/%s-tables.sh",self._basedir,key)
	return key,filename
end
local function createoutputpath(key)
        local path
        local dirname=posix.dirname(key)
        for dn in string.gmatch(dirname,"(/?[^/]+)") do
                path=path and path..dn or dn
                local ps=posix.stat(path)
                if ps == nil then
                        posix.mkdir(path)
--                elseif ps.type == "link" then
--                        posix.unlink(path)
--                        posix.mkdir(path)
                end
        end
        local ps=posix.stat(key)
        if ps and ps.type == "link" then
                posix.unlink(key)
        end
end
function M:output(r)
	local key,filename=self:outputkey(r)
	if M._filedescriptor[key] == nil then
		M._filename[key]=filename
    createoutputpath(filename)
		M._filedescriptor[key]=assert(io.open(filename,"w"))
	end
	return M._filedescriptor[key]
end
function M:closeall()
	for k,v in pairs(M._filedescriptor) do
		v:close()
	end
end
return M

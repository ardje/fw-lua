local M={}
M._tables={}
M._tables.nat={}
M._tables.filter={}
M._tables.mangle={}
M._sets={}
M.Object={_name="Object"}
M.MetaObject={}
function M.MetaObject:UnknownMethod(k,...)
	self:UnknownMethod(k,...)
end
function M.MetaObject.__index(self,k)
	return function(o,...)
		return M.MetaObject.UnknownMethod(o,k,...)
	end
end
M.Object.meta={ __index=M.Object }
M.Object.subclasses={}
M.Object.objects={}
function M.Object:New(name)
	local o={_name=name,super=self }
	o.meta={ __index=o,__tostring=self.__tostring }	
	o.subclasses={}
	o.objects={}
	setmetatable(o,self.meta)
	self.subclasses[name]=o
	M[name]=o
	return o
end
function M.Object:UnknownMethod(k)
	print("unknown method:",k,"for",self.name)
end
-- setmetatable(M.Object,M.MetaObject)
function M.Object:new(name)
	local o={_name=name,class=self._name}
	setmetatable(o,self.meta)
	self.objects[name]=o
	_G[name]=o
	return o
end
-- Broadcast phase runs to all subclasses
-- phases must exist as method
function M.Object:RunPhase(N,...)
	for _,aClass in pairs(self.subclasses) do
		print("phase: ",N," class: ",_)
		aClass:RunPhase(N,...)
	end
	for _,anObject in pairs(self.objects) do
		print("phase object: ",_)
		anObject[N](anObject,...)
	end
end
function M.Object:setup(...)
end
function M.Object:ClassName()
	if self.super ~= nil then
		print("ask super",self.super._name)
		return self.super:ClassName() .. ":"..self._name
	else
		return self._name
	end
end
function M.Object:__tostring()
	local t="object"
	if self.class==nil then t="class" end
	return  t .. " ".. self._name
end
M.Object:New("Net")
function M.Net:allow(...)
	print(...)
	--self:addRule(...)
end

M.Object:New("Host")
function M.Host:new(n)
	local o=self.super.new(self,n[1])
	print("Host:new",n[1])
	o.ip=n.ip
	o.net=n.net
	return o
end
function M.Host:allow(...)
	self.net:allow(self:asDestination(),...)
end
function M.Host:asDestination()
	return {"--destination",self.ip}
end


return M

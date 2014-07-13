local M={
	_name="Object",
	subclasses={},
	objects={}
}
--[[
fw.MetaObject={}
function fw.MetaObject:UnknownMethod(k,...)
	self:UnknownMethod(k,...)
end
function M.MetaObject.__index(self,k)
	return function(o,...)
		return M.MetaObject.UnknownMethod(o,k,...)
	end
end
-- setmetatable(M.Object,M.MetaObject)
-- ]]

--[[
  Since we don't have an Object yet, we have to create the structure by hand
]]
function M:__tostring()
	if self.class==nil then
		return "Class "..self:ClassName()
	else
		return  "Object "..self.class .."(".. self._name..")"
	end
end
M.meta={ __index=M, __tostring=M.__tostring }
function M:New(name)
	local o={_name=name,super=self }
	o.meta={ __index=o,__tostring=self.__tostring }	
	o.subclasses={}
	o.objects={}
	setmetatable(o,self.meta)
	self.subclasses[name]=o
	--fw[name]=o
	print("Created class:",name)
	return o
end
function M:UnknownMethod(k)
	print("unknown method:",k,"for",self.name)
end
function M:new(name)
	local o={_name=name,class=self._name}
	setmetatable(o,self.meta)
	self.objects[name]=o
	--_G[name]=o
	print("Created object:",name)
	return o
end
-- Broadcast phase runs to all subclasses
-- phases must exist as method
function M:RunPhase(N,...)
	for _,aClass in pairs(self.subclasses) do
		print("phase: ",N," class: ",_)
		aClass:RunPhase(N,...)
	end
	for _,anObject in pairs(self.objects) do
		print("phase object: ",_)
		anObject[N](anObject,...)
	end
end
function M:setup(...)
end
function M:Get(name)
	if self.objects[name]==nil then
		for _,aClass in pairs(self.subclasses) do
			local o=aClass:Get(name)
			if o ~= nil then
				return o
			end
		end
		return nil
	else
		return self.objects[name]
	end
end
function M:ClassName()
	if self.super ~= nil then
		-- print("ask super",self.super._name)
		return self.super:ClassName() .. ":"..self._name
	else
		return self._name
	end
end
local fw=require"fw"
--fw.Object=M
return M

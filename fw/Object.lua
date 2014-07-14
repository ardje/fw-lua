--[[
  Since we don't have an Object yet, we have to create the "structure" by hand
]]
local M={
	_mo={ name = "Object" }
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
local _M={ }

function M:_meta()
	self._mo.meta= self._mo.meta or { __index=self, __tostring=self.__tostring }
	return self._mo.meta
end

function M:_add(t,object)
	if object:Name() then
		self._mo[t]=self._mo[t] or {}
--		print("o",object:Name(),getmetatable(object))
		self._mo[t][object:Name()]=object
	end
end
function M:_get(t)
	return self._mo[t]
end

function M:__tostring()
	if self._mo.class==nil then
		return "Class "..self:ClassName()
	else
		return  "Object "..self._mo.class:ClassName() .."(".. self._mo.name..")"
	end
end
function M:_new(p)
	local o={_mo={}}
	if p ~= nil then
		local name
		if type(p)== "string" then
			name=p
		else
			name=p[1]
			for k,v in pairs(p) do
				if k ~= 1  then
					o[k]=v
				end
			end
		end
		o._mo.name=name
	end
	setmetatable(o,self:_meta())
	return o
end
function M:New(name)
	local o=self:_new(name)
	o._mo.super=self
	self:_add("subclasses",o)
	print("Created:",o)
	return o
end
function M:UnknownMethod(k)
	print("unknown method:",k,"for",self.name)
end
function M:new(name)
	local o=self:_new(name)
	o._mo.class=self
	self:_add("objects",o)
	print("Created:",o)
	return o
end
-- Broadcast phase runs to all subclasses and objects
-- phases must exist as method
function M:RunPhase(N,...)
	local subclasses=self:_get("subclasses")
	if subclasses ~= nil then
		for _,aClass in pairs(subclasses) do
			io.write("phase: ",N," class: ",aClass:ClassName(),"\n")
			aClass:RunPhase(N,...)
		end
	end
	local objects=self:_get("objects")
	if objects ~= nil then
		for _,anObject in pairs(objects) do
			print("phase object: ",_)
			anObject:RunPhase(N,...)
		end
	end
	if self[N] ~= nil then
		self[N](self,...)
	end
end
function M:Get(name)
	local objects=self:_get("objects")
	if objects ~= nil then
		if objects[name]==nil then
			local subclasses=self:_get("subclasses")
			if subclasses ~= nil then
				for _,aClass in pairs(subclasses) do
					local o=aClass:Get(name)
					if o ~= nil then
						return o
					end
				end
			end
		else
			return objects[name]
		end
	end
	return nil
end
function M:Name()
	return self._mo.name
end
function M:ClassName()
	if self._mo.super ~= nil then
		-- print("ask super",self.super._name)
		return self._mo.super:ClassName() .. ":"..self._mo.name
	else
		return self._mo.name
	end
end
--local fw=require"fw"
--fw.Object=M
return M

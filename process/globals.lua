local M={}
local declaredNames = {}
function M.declare(name, initval)
  rawset(_G, name, initval)
  declaredNames[name] = true
end
function M.exists(name)
  --print("searching for",name)
  return rawget(_G,name)~=nil
end
function M.get(name)
  --print("searching for",name)
  return rawget(_G,name)
end
M._meta={}
function M._meta.__newindex(t, n, v)
  if not declaredNames[n] then
    error("attempt to write to undeclared var. "..n, 2)
  else
    rawset(t, n, v)   -- do the actual set
  end
end
function M._meta.__index(_,n)
  if not declaredNames[n] then
    error("attempt to read undeclared var. "..n, 2)
  else
    return nil
  end
end
setmetatable(_G, M._meta)
return M

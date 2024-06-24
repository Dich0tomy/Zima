Module = {}

---@class Module
Module.Interface = {}

---Creates a new module
---@param other? table initial value
---@return Module Module interface
function Module:new(other)
  other = other or {}

  setmetatable(other, self.Interface)
  self.Interface.__index = self.Interface

  return other
end
return Module

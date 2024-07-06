local lu = zima.xpnequire('lua-utils')

local M = {}

---Returns the item that matches the first item in statements.
---@param value any The value to compare against
---@param compare? fun(lhs: any, rhs: any): boolean A custom comparison function
---@return fun(statements: table<any, any>): any # A function to invoke with a table of potential matches.
function M.match(value, compare)
  return lu.match(value, compare)
end

---Lazily concatenates a string to prevent runtime errors where an object may not exist
---Consider the following example:
---
---    lib.when(str ~= nil, str .. " extra text", "")
---
---This would fail, simply because the string concatenation will still be evaluated in order
---to be placed inside the variable. You may use:
---
---    lib.when(str ~= nil, lib.lazy_string_concat(str, " extra text"), "")
---
---To mitigate this issue directly.
---@param ... string An unlimited number of strings.
---@return string # The result of all the strings concatenated.
function M.lazy_string_concat(...)
  return lu.lazy_string_concat(...)
end


return M

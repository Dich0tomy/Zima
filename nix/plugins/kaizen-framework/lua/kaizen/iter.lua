local M = {}

---Splits the string by a given value and returns a table
---@param str string String to splitmpare against
---@param delim string Delimiter to split by
---@return string[] # Table of split elements
function M.split(str, delim)
	return vim.iter(str:gmatch(('[^%%%s]+'):format(delim))):totable()
end

return M

local M = {}

---Checks if a module is requirable without evaluating it
---@param modname Requirable Module modname
---@return boolean # Is the module requirable?
function M.requirable(modname)
	return vim.loader.find(modname) ~= {}
end

return M

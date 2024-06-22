local M = {}

---@package
---Expands `?` in `package.path` templates with the correct modname
---@param path string A path with a glob or not with the module
---@param modname string module name
---@return string[]
local function contains_module(path, modname)
	local equal = require('kaizen.fp').equal
	local exists = require('kaizen.path').exists
	local concat = require('kaizen.path').concat

	local file_mod = ('lua/%s.lua'):format(modname)
	local dir_mod = ('lua/%s/init.lua'):format(modname, modname)

	-- false - dont use 'suffixes' and 'wildignore'
	-- true - return a list
	return vim
		.iter(vim.fn.glob(path, false, true))
		:map(function(p)
			return exists(concat(p, file_mod)) or exists(concat(p, dir_mod))
		end)
		:any(equal(true))
end

---Checks if a module is requirable without evaluating it
---@param runtimepaths Path[] Runtime path
---@param modname Requirable Module modname
---@return boolean # Is the module requirable?
function M.requirable_from(runtimepaths, modname)
	local split = require('kaizen.iter').split
	local partial_back = require('kaizen.fp').partial_back
	local concat = require('kaizen.path').concat

	local normalized_modname = concat(split(modname, '.'))

	return vim.iter(runtimepaths):any(partial_back(contains_module, normalized_modname))
end

---Checks if a module is requirable without evaluating it
---@param modname Requirable Module modname
---@return boolean # Is the module requirable?
function M.requirable(modname)
	return M.requirable_from(vim.opt.rtp:get(), modname)
end

return M

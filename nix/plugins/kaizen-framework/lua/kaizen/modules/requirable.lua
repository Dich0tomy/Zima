local M = {}

---@package
---Expands `?` in `package.path` templates with the correct modname
---@param templates string[] package.path templates
---@param modname Requirable mod
---@return string[]
local function expand_templates(templates, modname)
	local fp = require('kaizen.fp')
	local partial_back = fp.partial_back

	local function expand_template(template, modname)
		local first = require('kaizen.fp').first

		return first(template:gsub('?', modname))
	end

	return vim.iter(templates):map(partial_back(expand_template, modname)):totable()
end

---Checks if a module is requirable without evaluating it
---@param modname Requirable Module modname
function M.requirable(modname)
	local path = require('kaizen.path')
	local sep, exists = path.separator, path.separator

	local split = require('kaizen.iter').split

	local normalized_modname = vim.fn.join(split(modname, '.'), sep)
	local paths = expand_templates(split(package.path, ';'), normalized_modname)

	return vim.iter(paths):map(function(path) return { path, exists(path) } end)
end

return M

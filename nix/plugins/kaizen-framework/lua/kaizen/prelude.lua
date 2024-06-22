---The global kaizen module
_G.kzn = {}

---@package
---@param level any log level
local function log_base(level)
	---Issues a notification via vim.notify
	---@param msg string Format string like in string.format
	---@param ... any Arguments to format
	return function(msg, ...)
		if msg then
			vim.notify((msg):format(...), level)
		end
	end
end

---Issues a notification error
_G.kzn.error = log_base(vim.log.levels.ERROR)

---Issues a notification warning
_G.kzn.warn = log_base(vim.log.levels.WARN)

---Issues a notification info
_G.kzn.info = log_base(vim.log.levels.INFO)

---Issues a notification trace
_G.kzn.trace = log_base(vim.log.levels.TRACE)

---Runs pcall on the require() function
---@param name string name of the module
---@return boolean status,table module
function _G.kzn.pequire(name)
	return pcall(require, name)
end

---Tries to run require(name) and notifies an error if it fails
---@param name string name of the module
---@return boolean status, table module
function kzn.xpnequire(name)
	return xpcall(function()
		return require(name)
	end, function()
		kzn.error(
		  debug.traceback(
		    ('Module "%s" could not be loaded'):format(name),
        4
		  )
		)
	end)
end

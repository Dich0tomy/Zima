_G.zf = {}

---@package
---@param level any log level
local function log_base(level)
	---Issues a notification via vim.notify
	---@param msg string Format string like in string.format
	---@param ... any Arguments to format
	return function(msg, ...)
		if msg then vim.notify((msg):format(...), level) end
	end
end

---Issues a notification error
_G.zf.error = log_base(vim.log.levels.ERROR)

---Issues a notification warning
_G.zf.warn = log_base(vim.log.levels.WARN)

---Issues a notification info
_G.zf.info = log_base(vim.log.levels.INFO)

---Issues a notification trace
_G.zf.trace = log_base(vim.log.levels.TRACE)

---Runs pcall on the require() function
---@param name string name of the module
---@return boolean status,table module
_G.zf.pequire = function(name) return pcall(require, name) end

---Tries to run require(name) and notifies an error if it fails
---@param name string name of the module
---@return boolean status, table module, any...
_G.zf.xpnequire = function(name)
	return xpcall(function() return require(name) end, function(err)
		local debuginfo = debug.getinfo(6, 'Sl')
		local error_location = ('%s:%s'):format(debuginfo.short_src, debuginfo.currentline)
		zf.error('Module "%s" could not be loaded.\nCalled from %s\nError:```\n%s\n```', name, error_location, err)
	end)
end

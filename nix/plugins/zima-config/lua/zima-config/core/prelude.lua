---The global kaizen module
_G.zima = {}

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
_G.zima.error = log_base(vim.log.levels.ERROR)

---Issues a notification warning
_G.zima.warn = log_base(vim.log.levels.WARN)

---Issues a notification info
_G.zima.info = log_base(vim.log.levels.INFO)

---Issues a notification trace
_G.zima.trace = log_base(vim.log.levels.TRACE)

---Runs pcall on the require() function
---@param name string name of the module
---@return boolean status,table module
function _G.zima.pequire(name)
	return pcall(require, name)
end

---Tries to run require(name) and notifies an error if it fails
---@param name string name of the module
---@return boolean status, table module
function zima.xpnequire(name)
	return xpcall(function()
		return require(name)
	end, function()
		zima.error(debug.traceback(('Module "%s" could not be loaded'):format(name), 4))
	end)
end

---Wraps a function and prints `unimplemented`, always
---@param func fun(any...): any func to wrap
---@return fun(): nil func
function zima.unimplemented(func)
  return function()
    vim.print('Unimplemented')
  end
end

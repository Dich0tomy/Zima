-- TODO: Create a Module log which will accumulate all the errors and dump it at the very end
-- WIll probably have to fixpoint the modules (z combinator) so that depends works
-- no matter in what order the modules are defined
-- Add validators to `config`

---@class KaizenModules
---@field config table<string, ModuleConfig> Modules configurations
---@field parts Requirable[] Required modules
_G.kzn.modules = {
	parts = {},
	config = {},
}

_G._Kaizen_UserDefinedModules = {}

---Loads the entire config
function kzn.modules.load()
	vim.iter(kzn.modules.parts):each(function(module_path)
		local requirable = require('kaizen.modules.requirable')

		local path, is_requireable = requirable.requirable(module_path)
		local ok, _module = kzn.pequire(module_path)

		if ok and is_requireable then
			kzn.info('Path %s is requirable', path)
		elseif ok and not is_requireable then
			kzn.error('Path %s is requirable but I dont work :(((((', path)
		elseif not ok and is_requireable then
			kzn.error('Path %s is falsely requirable', path)
		end
	end)
end

---Defines a module schema
---@param schema ModuleSchema Module definition
function kzn.modules.define(schema) end

---Instantiaties a module instance based on schema
---@param instance ModuleInstance Module instance
function kzn.modules.instantiate(instance) end

---Instantly defines and creates a module
---@param definition ModuleDefinition Full definition for the module
function kzn.modules.create(definition) end

---Creates a new module set to be exported
---@param members Requirable[] Module instance
---@return ModuleSet
function kzn.modules.set(members)
	local requirable = require('kaizen.modules.requirable')

	kzn.info('This impl only validates')

	vim.iter(members):each(function(module_path)
		local is_requireable = requirable.requirable(module_path)
		local ok, _module = kzn.pequire(module_path)

		if ok and not is_requireable then
			kzn.error('Module %s is falsely requirable', module_path)
		end
	end)
end

-- TODO: Create a Module log which will accumulate all the errors and dump it at the very end
-- WIll probably have to fixpoint the modules (z combinator) so that depends works
-- no matter in what order the modules are defined
-- Add validators to `config`

_G._ZimaModules = {}

---Defines a module schema
---@param schema ModuleSchema Module definition
function zf.modules.define(schema) end

---Instantiaties a module instance based on schema
---@param instance ModuleInstance Module instance
function zf.modules.instantiate(instance) end

---Instantly defines and creates a module
---@param definition ModuleDefinition Full definition for the module
function zf.modules.create(definition) end

---Creates a new module set to be exported
---@param members Requirable[] Module instance
---@return ModuleSet
function zf.modules.set(members)
	local requirable = require('zf-framework.modules.requirable')

	zf.info('This impl only validates')

	vim.iter(members):each(function(module_path)
		local is_requireable = requirable.requirable(module_path)
		local ok, _module = zf.pequire(module_path)

		if ok and not is_requireable then
			zf.error('Module %s is falsely requirable', module_path)
		end
	end)
end

---@meta

--[=[ Basic types ]=]

---@alias Requirable string A valid string that can be `required`

--[=[ Custom type types ]=]

---@alias LuaType string A valid lua type like boolean, int, function
---@alias DefinedType string A type defined with `zima.modules.new_type`

--[=[ Config types ]=]

---@alias ConfigType LuaType | DefinedType Either a lua type or a defined type

---@alias ModuleSchemaName string Module name
---@alias ModuleConfig table<string, any> Actual configuration, { name = value, [...] }

---@alias ModuleParts Requirable[] Requirables for zima modules, each requirable must evaluate to a ModuleSet
---@alias ModulesConfig table<string, ModuleConfigSchema> Actual configuration for modules

---@alias RequiredFilter fun(config: ModuleConfig): boolean
---@alias DefaultFun fun(config: ModuleConfig): any

---@alias SimpleConfigSchemaField ConfigType

---@class FullConfigSchemaField
---@field type ConfigType The type of the field
---@field default? any | DefaultFun Default value for this field
---@field required? boolean | RequiredFilter `true` by default
---@field parse? fun(field: ConfigSchemaField): any A parse function that will either return an error value or a parsed field value

---@alias ConfigSchemaField SimpleConfigSchemaField | FullConfigSchemaField

---@alias ModuleConfigSchema table<string, ConfigSchemaField>

--[=[ Module classes ]=]

---@class ModuleSet
---@field members string The name of the module

---@class ModuleSchema
---@field name ModuleSchemaName The name of the module
---@field config? ModuleConfig Config definition
---@field depends? ModuleSchemaName[] Dependent modules

---@class ModuleInstance
---@field module ModuleSchemaName What module this is
---@field entry fun(config?: ModuleConfigSchema) The entrypoint of the module

---@class ModuleDefinition
---@field name ModuleSchemaName The name of the module
---@field config? ModuleConfig Config definition
---@field depends? ModuleSchemaName[] Dependent modules
---@field entry fun(config?: ModuleConfigSchema) The entrypoint of the module

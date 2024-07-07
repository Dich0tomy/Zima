local fp = require('zima-config.lib.fp')
local iter = require('zima-config.lib.iter')

local M = {}

---Partitions modules to requireable ones and ones not found
---@param mods string[] Modules to load
---@return string[] good # Good modules
---@return string[] bad # Bad modules
local function partition_modules(mods)
  local specs = vim.iter(mods)
    :map(function(modname)
      return { modname, vim.tbl_isempty(vim.loader.find(modname)) }
    end)
    :totable()

  local unwrap_mods = fp.chain(unpack, fp.first)

  local good, bad = iter.partition(specs, fp.chain(unpack, fp.second, fp.equal(false)))

  return
    vim.iter(good):map(unwrap_mods):totable(),
    vim.iter(bad):map(unwrap_mods):totable()
end

---Notifies the user about not found modules
---@param bad string[] Module paths
local function notify_bad(bad)
  if #bad ~= 0 then
    local error = vim.iter(bad)
      :map(fp.chain(vim.inspect, fp.fmt('- %s')))
      :join('\n')

    zima.error('Failed to load the following modules:\n%s', error)
  end
end

---Loads a list of modules and extracts plugin info from them
---@param mods string[] Paths to modules
function M.load_modules(mods)
  local good, bad = partition_modules(mods)

  notify_bad(bad)

  local loaded_good = vim.iter(good)
    :map(require)
    :flatten()
    :totable()

  local setup_ok, possible_error = pcall(require('lz.n').load, loaded_good)
  if not setup_ok then
    zima.error('While trying to setup the provider with specs!\n%s', possible_error)
  end
end

return M

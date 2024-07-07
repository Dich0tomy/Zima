local M = {}

---Loads a list of modules and extracts plugin info from them
---@param mods any func to wrap
---@param provider any which provider to use, default = lz.n
function M.load_modules(mods, provider)
  provider = provider or 'lz.n'

  local fp = require('zima-config.lib.fp')
  local iter = require('zima-config.lib.iter')

  local specs = vim.iter(mods)
    :map(function(modname)
      return { modname, vim.tbl_isempty(vim.loader.find(modname)) }
    end)
    :totable()

  local unwrap_mods = fp.chain(unpack, fp.first)

  local good, bad = iter.partition(specs, fp.chain(unpack, fp.second, fp.equal(false)))

  if #bad ~= 0 then
    local error = vim.iter(bad)
      :map(unwrap_mods)
      :map(fp.chain(vim.inspect, fp.fmt('- %s')))
      :join('\n')

    zima.error('Failed to load the following modules:\n%s', error)
  end

  local provider_ok, possible_provided = zima.pequire(provider)
  if not provider_ok then
    zima.error('Cannot require the provider!\n%s', possible_provided)
    return
  end

  local loaded_good = vim.iter(good)
    :map(fp.chain(unwrap_mods, require))
    :flatten()
    :totable()

  zima.trace('Loaded goods: %s', loaded_good)

  local setup_ok, possible_error = pcall(possible_provided.load, loaded_good)
  if not setup_ok then
    zima.error('While trying to setup the provider with specs!\n%s', possible_error)
  end
end

return M

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
      return { modname, fp.second(zima.pequired(modname)) }
    end)

  local good, bad = iter.partition(specs, fp.chain(unpack, fp.second, fp.equal(true)))

  if #bad ~= 0 then
    local error = vim.iter(bad)
      :map(function(name) return ('- %s'):format(name) end)
      :join('\n')

    zima.error(('Failed to load the following modules:\n%s'):format(error))
  end

  local ok, result = zima.pequire(provider)
  if not ok then
    zima.error(('Cannot require the provider!\n%s'):format(result))
  end

  ok, result = pcall(result.setup, good)

  if not ok then
    zima.error(('While trying to setup the provider with specs!\n%s'):format(result))
  else
    zima.info('Successfully loaded all the user modules!');
  end
end

return M

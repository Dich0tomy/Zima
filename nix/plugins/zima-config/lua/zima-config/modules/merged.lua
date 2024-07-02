local plugins = {}

local add = function(path)
  for _, p in ipairs(require(path)) do
    plugins.insert(p)
  end
end

add('zima-config.modules.debugging')
add('zima-config.modules.debugging')
add('zima-config.modules.lsp')

return plugins

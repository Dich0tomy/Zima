rockspec_format = '3.0'

local _MODREV, _SPECREV = 'scm', '-1'
version = _MODREV .. _SPECREV

package = "zima-config"

source = {
  url = "file://."
}

test_dependencies = {
  'lua >= 5.1',
  'plenary.nvim',
  'nlua',
}
build = {
  type = "builtin",
}

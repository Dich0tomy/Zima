-- TODO: Plugins, module system akin to NixOS
return {
  require('zima-config.modules.theming.tokyonight'),
  require('zima-config.modules.theming.kanagawa'),
  require('zima-config.modules.theming.melange'),
  require('zima-config.modules.theming.nightfox'),
  require('zima-config.modules.theming.fleet-theme'),
  require('zima-config.modules.theming.mountain'),
  require('zima-config.modules.theming.gruvbox'),
  require('zima-config.modules.theming.nord')
}

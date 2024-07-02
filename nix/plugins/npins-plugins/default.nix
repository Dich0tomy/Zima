# Taken from https://github.com/NobbZ/nobbz-vim
# and slightly modified
{
  lib,
  npins',
  vimUtils,
  ...
}: let
  makePluginFromPin = name: pin:
    vimUtils.buildVimPlugin {
      pname = name;
      version = pin.version or pin.revision;
      src = pin;
    };

  pluginPred = name: _: !((lib.hasPrefix "nixpkgs" name) || (name == "neovim"));
in
  lib.pipe npins' [
    (lib.filterAttrs pluginPred)
    (lib.mapAttrs' (name: pin: lib.nameValuePair name pin))
    (lib.mapAttrs makePluginFromPin)
  ]

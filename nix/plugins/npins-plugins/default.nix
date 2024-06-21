# Taken from https://github.com/NobbZ/nobbz-vim
# and slightly modified
{
	npins,
	vimUtils,
	lib,
  ...
}: let
  makePluginFromPin = name: pin:
		vimUtils.buildVimPlugin {
			pname = name;
			version = pin.version or pin.revision;
			src = pin;
		};

  pluginPred = name: _: !((lib.hasPrefix "nixpkgs" name) || (name == "neovim"));
in lib.pipe npins [
    (lib.filterAttrs pluginPred)
		# (lib.mapAttrs' lib.nameValuePair)
		(lib.mapAttrs makePluginFromPin)
  ]

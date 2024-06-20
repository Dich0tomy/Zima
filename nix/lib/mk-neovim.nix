{
  wrapNeovimUnstable,
  neovim-unwrapped,
  neovimUtils,
  lib,
  ...
}: {
  src,
  plugins ? [],
  runtimeInputs ? [],
  extraLuaPackages ? (_: []),
}: let
  neovim = neovim-unwrapped.overrideAttrs {
    src = src;
    version = src.revision;
    patches = [];
    preConfigure = ''
      sed -i cmake.config/versiondef.h.in -e "s/@NVIM_VERSION_PRERELEASE@/-dev-$version/"
    '';
  };

  config = neovimUtils.makeNeovimConfig {
    inherit plugins extraLuaPackages;
  };
in
  (wrapNeovimUnstable neovim config).overrideAttrs (prev: {
    generatedWrapperArgs =
      prev.generatedWrapperArgs
      or []
      ++ [
        "--prefix"
        "PATH"
        ":"
        (lib.makeBinPath runtimeInputs)
      ];
  })

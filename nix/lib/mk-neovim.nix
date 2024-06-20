{
  writeShellApplication,
  wrapNeovimUnstable,
  neovim-unwrapped,
  neovimUtils,
  lib,
  ...
}: {
  name,
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

  wrapped-neovim = (wrapNeovimUnstable neovim config).overrideAttrs (prev: {
    generatedWrapperArgs =
      prev.generatedWrapperArgs
      or []
      ++ [
        "--prefix"
        "PATH"
        ":"
        (lib.makeBinPath runtimeInputs)
      ];
  });
in
  writeShellApplication {
    inherit name;

    runtimeInputs = [wrapped-neovim];

    text = ''
      nvim --clean "$@"
    '';
  }

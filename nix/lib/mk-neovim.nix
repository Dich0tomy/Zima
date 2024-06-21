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
    postFixup = prev.postFixup or "" + ''
      mv $out/bin/{nvim,${name}}
    '';

    generatedWrapperArgs =
      prev.generatedWrapperArgs
      or []
      ++ [
        "--prefix"
        "PATH"
        ":"
        (lib.makeBinPath runtimeInputs)
      ] ++ [
        "--set"
        "NVIM_APPNAME"
        "50met0t411yn0n5en5ev41ue"
      ];
  });
in
  wrapped-neovim

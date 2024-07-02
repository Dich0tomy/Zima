{
  wrapNeovimUnstable,
  neovim-unwrapped,
  neovimUtils,
  lib,
  npins',
  ...
}: {
  name,
  src ? npins'.neovim,
  viAlias ? false,
  vimAlias ? false,
  plugins ? [],
  runtimeInputs ? [],
  extraLuaPackages ? (_: []),
}: let
	# TODO: Clean this from rtp
  nonsenseValue = "50me_t0t411y_n0n5en5e_v41ue";

  neovim = neovim-unwrapped.overrideAttrs {
    src = src;
    version = src.revision;
    patches = [];
    preConfigure = ''
      sed -i cmake.config/versiondef.h.in -e "s/@NVIM_VERSION_PRERELEASE@/-dev-$version/"
    '';
  };

  config = neovimUtils.makeNeovimConfig {
    inherit plugins extraLuaPackages viAlias vimAlias;
  };

  wrapped-neovim = (wrapNeovimUnstable neovim config).overrideAttrs (prev: {
    meta.mainProgram = name;

    postFixup =
      prev.postFixup
      or ""
      + ''
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
      ]
      ++ [
        "--set"
        "NVIM_APPNAME"
        nonsenseValue
      ];
  });
in
  wrapped-neovim

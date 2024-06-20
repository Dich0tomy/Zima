{
  npins,
  zima-lib,
  wrapNeovimUnstable,
  neovim-unwrapped,
  neovimUtils,
  # Nonexistent plugins will be added with an overlay
  vimPlugins,
  lua-language-server,
  ripgrep,
  fd,
}:
zima-lib.mkNeovim {
  src = npins.neovim;

  plugins = with vimPlugins; [
    nvim-treesitter.withAllGrammars
    # TODO:
  ];

  runtimeInputs = [
    lua-language-server
    ripgrep
    fd
  ];
}

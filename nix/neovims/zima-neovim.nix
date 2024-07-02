{
  self',
  zima-lib,
  vimPlugins,
  lua-language-server,
  ripgrep,
  fd,
  luarocks,
  luajit,
}:
zima-lib.mkNeovim {
  name = "zima";

  plugins = with vimPlugins;
    [
      # Go through all these and consider alternatives
      # Group them
      nvim-treesitter.withAllGrammars
      neogit
      nvim-luapad
      diffview-nvim
      lualine-nvim # for now, Ill switch to either heirline or write my own
      oil-nvim
      nvim-web-devicons
      kanagawa-nvim
      glance-nvim
      neorg
      nvim-notify
      leap-nvim
      flit-nvim # Consider flash.nvim
      fidget-nvim
      nvim-treesitter-context
      scope-nvim
      indent-blankline-nvim # Consider other solutions here as well
      telescope-nvim
      gitsigns-nvim
      comment-nvim
      nvim-cmp
      nvim-cmp
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      cmp-buffer
      cmp_luasnip
      nvim-lspconfig
      luasnip
      nvim-unception
      vim-eunuch
      lspkind-nvim
      harpoon # surely, but need to read
      vim-rhubarb # possibly
      image-nvim # need to see what's the metae now
      treesj #- need to read the readme and shi
      mini-nvim # need to see what's there
      text-case-nvim
      nightfox-nvim # carbonfox
      hydra-nvim
      otter-nvim
      rustaceanvim
      lsp_lines-nvim
      git-conflict-nvim
      tabout-nvim
      melange-nvim
      glance-nvim
      stylish-nvim
      scope-nvim
      telescope-sg # Telescope for semantic grep
      fleet-theme-nvim
      replacer-nvim # Inline replacing in qflist
      hmts-nvim # Treesitter highlighting of home manager inline code
      nvim-bqf
      lz-n # Lazy loading

      # Check options https://github.com/vhyrro/config/blob/main/rocks.toml
      # https://github.com/mobily/.nvim/tree/main/lua/pickers/spectre
      # github prescientmoon/scrap.nvim -- contribute to that bitch, add a Subst
    ]
    ++ builtins.attrValues (self'.legacyPackages.vimPlugins or {});

  extraLuaPackages = p: [
    p.magick
  ];

  runtimeInputs = [
    lua-language-server
    luarocks
    luajit
    ripgrep
    fd
  ];
}

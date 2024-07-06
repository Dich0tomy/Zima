{inputs, ...}: {
  perSystem = {
    pkgs,
    system,
    config,
    ...
  }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ inputs.neorocks.overlays.default ];
    };

    checks.default = pkgs.writeShellApplication {
      name = "typos-check";

      runtimeInputs = [
        pkgs.gum
        pkgs.typos
      ];

      text = ''
        gum style --border="rounded" --padding="0 1" --bold --border-foreground="#ffc0cb" "Running typos!"
        typos .
        '';
    };

    checks.neorocks = pkgs.neorocksTest {
      name = "zima-config";

      src = config.legacyPackages.vimPlugins.zima-config;
      neovim = config.packages.default;

      luaPackages = ps: [
        ps.plenary-nvim
      ];
    };
  };
}

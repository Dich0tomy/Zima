{
  description = ''
    Zima Blue, the manufacturer called it.
    The first thing I ever saw.
    This was where I began.
    A crude little machine with barely enough intelligence to steer itself.
    But it was my world.
    It was all I knew, all I needed to know.

    And now?

    I will immerse myself.
    And as I do, I will slowly shut down my higher brain functions...

    un-making myself...

    leaving just enough to appreciate my surroundings ...

    to extract some simple pleasure from the execution of a task well done.

    My search for truth is finished at last.
    I'm going home.
  '';

  outputs = {parts, ...} @ inputs:
    parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        ./nix/plugins # Config plugin, config framework, external plugins
        ./nix/checks.nix
      ];

      perSystem = {
        pkgs,
        self',
        ...
      }: {
        _module.args.npins' = import ./npins;

        imports = [
          ./nix/lib

          ./nix/formatter.nix
          ./nix/shell.nix

          ./nix/neovims
        ];
      };
    };

  inputs = {
    parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neorocks.url = "github:nvim-neorocks/neorocks";
  };
}

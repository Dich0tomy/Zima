{
  pkgs,
  self',
  ...
}: {
  devShells.default = pkgs.mkShellNoCC {
    packages = [
      self'.packages.default
      pkgs.lua-language-server
      pkgs.stylua
    ];
  };
}

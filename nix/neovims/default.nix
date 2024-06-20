{
  pkgs,
  npins,
  zima-lib,
  self',
  ...
}: {
  packages.zima = pkgs.callPackage ./zima-neovim.nix {inherit self' npins zima-lib;};
  packages.default = self'.packages.zima;
}

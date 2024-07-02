{
  pkgs,
  zima-lib,
  self',
  ...
}: {
  packages.zima = pkgs.callPackage ./zima-neovim.nix {inherit self' zima-lib;};
  packages.default = self'.packages.zima;
}

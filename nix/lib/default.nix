{pkgs, npins', ...}: {
  _module.args.zima-lib = {
    mkNeovim = import ./mk-neovim.nix (pkgs // { inherit npins'; });
 };
}

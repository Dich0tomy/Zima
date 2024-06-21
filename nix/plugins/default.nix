{
  self,
  nixpkgs,
  system,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    npins',
    ...
  }: {
    # https://github.com/otavioschwanck/arrow.nvim
    legacyPackages.vimPlugins =
      {
        zima-config = pkgs.callPackage ./zima-config {inherit self;};
        zima-framework = pkgs.callPackage ./zima-framework {inherit self;};
      }
      // (import ./npins-plugins (pkgs // {inherit npins';}));
  };
}

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
    legacyPackages.vimPlugins =
      {
        zima-config-plugin = pkgs.callPackage ./zima-config {inherit self;};
        zima-framework-plugin = pkgs.callPackage ./zima-framework {inherit self;};
      }
      // (import ./npins-plugins (pkgs // {inherit npins';}));
  };
}

{
  self,
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
        zima-config = pkgs.callPackage ./zima-config {inherit self;};
      }
      // (import ./npins-plugins (pkgs // {inherit npins';}));
  };
}

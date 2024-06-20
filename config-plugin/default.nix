{
  self,
  nixpkgs,
  system,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    _module.args.nixpkgs = import nixpkgs {
      inherit system;

      overlays = [
        (_: prev: {
          legacyPackages.vimPlugins.zima-config-plugin =
            prev.vimPlugins
            // {
              zima-config-plugin = pkgs.vimUtils.buildVimPlugin {
                pname = "zima-config-plugin";
                version = self.shortRev or self.dirtyRev or "dirty";

                src = lib.fs.fileFilter (f: f.hasExt "lua") "${self}/config-plugin";
              };
            };
        })
      ];
    };
  };
}

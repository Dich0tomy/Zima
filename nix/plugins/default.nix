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
  	legacyPackages.vimPlugins = {
			zima-config-plugin = pkgs.vimUtils.buildVimPlugin {
				pname = "zima-config-plugin";
				version = self.shortRev or self.dirtyRev or "dirty";

				# src = lib.fileset.fileFilter (f: f.hasExt "lua") (./. + "/${self}/config-plugin");
				src = "${self}/config-plugin";
			};
  	} // (pkgs.callPackage ./npins-plugins {});
  };
}

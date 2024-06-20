{
  vimUtils,
  lib,
  self,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "zima-framework-plugin";
  version = self.shortRev or self.dirtyRev or "dirty";

  src = builtins.path {
    name = "zima-framework";
    path = ./.;
  };
}

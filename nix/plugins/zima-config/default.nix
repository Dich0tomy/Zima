{
  vimUtils,
  lib,
  self,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "zima-config";
  version = self.shortRev or self.dirtyRev or "dirty";

  src = builtins.path {
    name = "zima-config";
    path = ./.;
  };
}

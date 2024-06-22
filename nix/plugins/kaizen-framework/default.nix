{
  vimUtils,
  lib,
  self,
  ...
}:
vimUtils.buildVimPlugin {
  pname = "kaizen-framework";
  version = self.shortRev or self.dirtyRev or "dirty";

  src = builtins.path {
    name = "kaizen-framework";
    path = ./.;
  };
}

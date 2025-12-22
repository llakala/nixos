{ self, ... }:

{
  environment.systemPackages = [
    self.wrappers.git.drv
    self.wrappers.diff-so-fancy.drv # TODO: don't install once I can avoid infrec
  ];
}

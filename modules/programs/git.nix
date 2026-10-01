{ self, ... }:

{
  environment.systemPackages = [
    self.wrappers.git.result
    self.wrappers.diff-so-fancy.result # TODO: don't install once I can avoid infrec
  ];
}

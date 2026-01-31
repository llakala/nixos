{ self, ... }:

{
  environment.systemPackages = with self.wrappers; [
    gh.drv
    less.drv
    ripgrep.drv
    zoxide.drv
  ];
}

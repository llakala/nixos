{ self, ... }:

{
  environment.systemPackages = with self.wrappers; [
    gh.result
    less.result
    ripgrep.result
    zoxide.result
  ];
}

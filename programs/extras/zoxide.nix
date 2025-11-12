{ self, lib, ... }:

{
  features.fuzzyCd = "zoxide";
  environment.systemPackages = [ self.wrappers.zoxide.drv ];

  hm.programs.fish.interactiveShellInit = ''
    ${lib.getExe self.wrappers.zoxide.drv} init fish ${self.wrappers.zoxide.flags} | source
  '';
}

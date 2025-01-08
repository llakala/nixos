{ self, pkgs, ... }:
let
  selfPackages = self.packages.${pkgs.system};
in
{
  # Get names from https://github.com/vitallium/tokyonight-fish/tree/04fc51e/themes
  hm.programs.fish.shellInit =
  ''
    fish_config theme choose "TokyoNight Night"
  '';

  hm.xdg.configFile."fish/themes" =
  {
    source = selfPackages.tokyonight-fish + "/share/fish/themes";
  };


}
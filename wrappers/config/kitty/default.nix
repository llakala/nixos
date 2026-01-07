{ adios }:
{
  options = {
    configFile.default = ./kitty.conf;
    themeFile.defaultFunc = { inputs }:
      "${inputs.nixpkgs.pkgs.kitty-themes}/share/kitty-themes/themes/Kaolin_Aurora.conf";
  };
}

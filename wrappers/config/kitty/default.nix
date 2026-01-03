{ adios }:
{
  options = {
    configFile.default = ./kitty.conf;
    themeFile.defaultFunc = { inputs }: import ./theme.nix { inherit inputs; };
  };
}

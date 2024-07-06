{ nixos-generators, ...}:

{
  imports =
  [
    nixos-generators.nixosModules.all-formats
  ];


  formatConfigs.my-custom-format =
  { config, modulesPath, ... }:
  {
    imports = [ "${toString modulesPath}/installer/cd-dvd/installation-cd-base.nix" ];
    formatAttr = "isoImage";
    fileExtension = ".iso";
    networking.wireless.networks = {
      # ...
    };
  };
}
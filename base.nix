{ disko, ... }:


{
  nix =
  {
    modules =
    [
      ./baseNix/core
      ./baseNix/features
      ./baseNix/os
      ./baseNix/software

      ./packages/nixPackages.nix

      ./overlays

      disko.nixosModules.disko
    ];
  };

  home =
  {
    modules =
    [
      ./baseHome/core
      ./baseHome/features
      ./baseHome/os
      ./baseHome/software

      ./packages/homePackages.nix

      ./overlays
    ];
  };
}
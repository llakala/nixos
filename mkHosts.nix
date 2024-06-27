{

  mkHosts = system: hosts:
  lib.genAttrs
  (
    hostName:
    lib.nixosSystem
    {
      modules =
      [
        ./baseNix/core
        ./baseNix/features
        ./baseNix/os
        ./baseNix/software
        ./packages/nixPackages.nix
        ./overlays

        "./${hostName}/nix"
        "./${hostName}/nixware"
      ];
    }
  ) hosts

}
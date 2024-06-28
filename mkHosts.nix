{ lib, pkgs, inputs, pkgs-unstable, vars, ...}:

let
  helpers =
  {
    inherit inputs pkgs-unstable vars;
  };

in
{
  generateNix = system: hosts:
  lib.genAttrs hosts
  (
    hostName:
    lib.nixosSystem
    {
      inherit system;

      modules =
      [
        ./baseNix/core
        ./baseNix/features
        ./baseNix/os
        ./baseNix/software
        ./packages/nixPackages.nix
        ./${hostName}/nix
        ./${hostName}/nixware
        {
          nixpkgs.pkgs = pkgs;
        }
      ];

      specialArgs = helpers //
      {
        hostVars = import ./${hostName}/${hostName}Vars.nix;
      };
    }
  );


  generateHome = system: hosts:
  lib.genAttrs hosts
  (
    hostName:
    inputs.home-manager.lib.homeManagerConfiguration
    {
      inherit pkgs;

      modules =
      [
        ./baseHome/core
        ./baseHome/features
        ./baseHome/os
        ./baseHome/software
        ./packages/homePackages.nix
        ./${hostName}/home
        ./${hostName}/homeware
      ];

      extraSpecialArgs = helpers //
      {
        hostVars = import ./${hostName}/${hostName}Vars.nix;
      };
    }
  );

}
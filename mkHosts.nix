{ lib, inputs, pkgs, pkgs-unstable, vars, ...}:

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
        ./base/nix/core
        ./base/nix/features
        ./base/nix/os
        ./base/nix/software

        ./overlays
        ./packages/nixPackages.nix

        {
          nixpkgs.pkgs = pkgs; # Use pkgs declared in flake.nix with custom options
        }
        inputs.disko.nixosModules.disko

        ./${hostName}/nix
        ./${hostName}/nixware
      ];

      specialArgs = helpers //
      {
        hostVars = import ./${hostName}/${hostName}Vars.nix;
      };
    }
  );


  generateHome = users: hosts:
  builtins.listToAttrs
  (
    lib.lists.imap0
    (
      index: hostName:
      lib.nameValuePair
      (
        ( builtins.elemAt users index ) # Current user
        + "@" + hostName
      )


      (inputs.home-manager.lib.homeManagerConfiguration
      {
        inherit pkgs;
        modules =
        [
          ./base/home/core
          ./base/home/features
          ./base/home/os
          ./base/home/software

          ./overlays
          ./packages/homePackages.nix

          ./${hostName}/home
          ./${hostName}/homeware
        ];
        extraSpecialArgs = helpers //
        {
          hostVars = import ./${hostName}/${hostName}Vars.nix;
        };
      })
    )
    hosts
  );

}
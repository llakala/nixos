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
        ./base/nix/os
        ./base/nix/software

        ./hosts/${hostName}/nix
        ./hosts/${hostName}/nixware

        ./resources/overlays
        ./resources/packages/nixPackages.nix

        {
          nixpkgs.pkgs = pkgs; # Use pkgs declared in flake.nix with custom options
        }
        inputs.disko.nixosModules.disko
        ./hosts/${hostName}/nix
        ./hosts/${hostName}/nix
      ];

      specialArgs = helpers //
      {
        hostVars = import ./hosts/${hostName}/${hostName}Vars.nix;
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
          ./base/home/os
          ./base/home/software

          ./hosts/${hostName}/home
          ./hosts/${hostName}/homeware

          ./resources/overlays
          ./resources/packages/homePackages.nix
        ];
        extraSpecialArgs = helpers //
        {
          hostVars = import ./hosts/${hostName}/${hostName}Vars.nix;
        };
      })
    )
    hosts
  );

}
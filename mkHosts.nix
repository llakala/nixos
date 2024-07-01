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

        ./overlays
        ./packages/nixPackages.nix

        {
          nixpkgs.pkgs = pkgs; # Use pkgs declared in flake.nix with custom options
        }
        inputs.disko.nixosModules.disko

        ./hosts/${hostName}/nix
        ./hosts/${hostName}/nixware
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

          ./overlays
          ./packages/homePackages.nix

          ./hosts/${hostName}/home
          ./hosts/${hostName}/homeware
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
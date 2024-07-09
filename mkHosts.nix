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
        ./base/core/nix
        ./base/os/nix
        ./base/software/nix

        ./${hostName}/modules/nix
        ./${hostName}/software/nix

        ./resources/overlays

        {
          nixpkgs.pkgs = pkgs; # Use pkgs declared in flake.nix with custom options
        }
        inputs.disko.nixosModules.disko

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
          ./base/core/home
          ./base/os/home
          ./base/software/home

          ./${hostName}/modules/home
          ./${hostName}/software/home

          ./resources/overlays

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

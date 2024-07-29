{ lib, inputs, pkgs, pkgs-unstable, ...}:

let
  helpers =
  {
    vars = import ./base/baseVars.nix;
    inherit inputs pkgs-unstable;
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
        ./base/gnome/nix
        ./base/software/nix
        ./base/terminal/nix

        ./${hostName}/core/nix
        ./${hostName}/gnome/nix
        ./${hostName}/software/nix
        ./${hostName}/terminal/nix

        ./${hostName}/hardware-configuration.nix # NIX ONLY

        ./resources/overlays

        {
          nixpkgs.pkgs = pkgs; # Use pkgs declared in flake.nix with custom options
        }
        inputs.disko.nixosModules.disko

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
          ./base/core/home
          ./base/gnome/home
          ./base/software/home
          ./base/terminal/home

          ./${hostName}/core/home
          ./${hostName}/gnome/home
          ./${hostName}/software/home
          ./${hostName}/terminal/home

          ./resources/overlays

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

{ lib, inputs, pkgs, pkgs-unstable, ...}:

let
  helpers =
  {
    vars = import ./base/baseVars.nix;
    inherit inputs pkgs-unstable;
  };

  importAll =
  dir:
    lib.mapAttrsToList
    (
      n: _: dir + "/${n}"
    )
    (builtins.readDir dir);

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
      importAll ./base/core/nixos ++
      importAll ./base/gnome/nixos ++
      importAll ./base/software/nixos ++
      importAll ./base/terminal/nixos ++
      [

        ./${hostName}/core/nixos
        ./${hostName}/gnome/nixos
        ./${hostName}/software/nixos
        ./${hostName}/terminal/nixos

        ./${hostName}/hardware-configuration.nix # NIX ONLY

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

{ lib, inputs, pkgs, pkgs-unstable, ...}:

let
  helpers =
  {
    vars = import ./base/baseVars.nix;
    inherit inputs pkgs-unstable;
  };

  importNixFiles = dir:
  lib.mapAttrsToList
  (
     file: _: dir + "/${file}"
  )
  (lib.filterAttrs
    (
      file: _: lib.hasSuffix ".nix" file
    )
    (builtins.readDir dir)
  );

  importFolders =
  dirs:
  lib.concatMap
  (
    dir: importNixFiles dir
  )
  (
    dirs
  );

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
      importNixFiles ./base/core/nixos ++
      importNixFiles ./base/gnome/nixos ++
      importNixFiles ./base/software/nixos ++
      importNixFiles ./base/terminal/nixos ++
      importNixFiles ./${hostName}/core/nixos ++
      # importNixFiles ./${hostName}/gnome/nixos ++
      importNixFiles ./${hostName}/software/nixos ++
      # importNixFiles ./${hostName}/terminal/nixos ++
      [

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

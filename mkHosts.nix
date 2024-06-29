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


  generateHome = users: hosts:
  builtins.listToAttrs
  (
    lib.lists.imap0
    (
      index: host:
      lib.nameValuePair
      (
        ( builtins.elemAt users index )
        + "@" + host
      )


      (inputs.home-manager.lib.homeManagerConfiguration
      {
        inherit pkgs;
        modules =
        [
          ./baseHome/core
          ./baseHome/features
          ./baseHome/os
          ./baseHome/software
          ./packages/homePackages.nix
          ./${host}/home
          ./${host}/homeware
        ];
        extraSpecialArgs = helpers //
        {
          hostVars = import ./${host}/${host}Vars.nix;
        };
      })


    )
    hosts
  );

}
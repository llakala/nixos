    {
        description = "A simple NixOS flake";

        inputs =
        {
            nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
            nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
            home-manager =
            {
                url = "github:nix-community/home-manager";
                inputs.nixpkgs.follows = "nixpkgs";
            };

        };


        outputs = inputs @
        {
            self,
            nixpkgs,
            nixpkgs-stable,
            home-manager,
            ...
        }:


        let

            lib = nixpkgs.lib;
            vars = import ./variables.nix;


            hostName = builtins.readFile "${vars.configDirectory}/secrets/host.nix";
            host = import ./${hostName}/profile.nix;

            pkgsArgs = {  system = host.system; config.allowUnfree = true; };
            pkgs = import nixpkgs pkgsArgs;
            pkgs-stable = import nixpkgs-stable pkgsArgs;

            base = import ./profile.nix { inherit inputs pkgs-stable vars; };

            baseNix = base.nixos;
            baseHome = base.home;
            hostNix = host.nixos;
            hostHome = host.home;

        in
        {
            nixosConfigurations."mypc" = nixpkgs.lib.nixosSystem
            {
                system = host.system;
                modules = baseNix.modules ++ hostNix.modules;
                specialArgs =
                {
                    inherit pkgs-stable vars inputs;
                };
            };




            homeConfigurations."mypc" = home-manager.lib.homeManagerConfiguration
            {
                inherit pkgs;
                modules = baseHome.modules ++ hostHome.modules;
                extraSpecialArgs =
                {
                    inherit pkgs-stable vars inputs;
                };
            };
        };
    }

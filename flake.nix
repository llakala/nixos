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
        vars = import ./variables.nix;
        system = vars.system;
        lib = nixpkgs.lib;

        pkgsArgs = { inherit system; config.allowUnfree = true; };
        pkgs = import nixpkgs pkgsArgs;
        pkgs-stable = import nixpkgs-stable pkgsArgs;

    in
    {
        nixosConfigurations = 
        {
            username = lib.nixosSystem
            {   
                modules =
                [

                    ./nixos/os

                    ./nixos/software

                    ./desktop/nixos

                    ./packages/nixos-pkgs.nix
                ];
                specialArgs =
                {
                    inherit pkgs-stable vars inputs;
                };
            };
        };


        homeConfigurations = 
        {
            username = home-manager.lib.homeManagerConfiguration
            {
                inherit pkgs;
                modules =
                [
                    ./home/os

                    ./home/software

                    ./desktop/home

                    ./packages/home-pkgs.nix
                ];
                extraSpecialArgs =
                {
                    inherit pkgs-stable vars inputs;
                };
            };


        };
    };
}
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
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    in
    {

        nixosConfigurations.${vars.hostName} = lib.nixosSystem
        {
            modules =
            [

                ./nixos/os

                ./nixos/packages

                ./nixos/software

                ./nixos/system
            ];
            specialArgs =
            {
                inherit pkgs-stable vars inputs;
            };
        };


        homeConfigurations.${vars.username} = home-manager.lib.homeManagerConfiguration
        {
            inherit pkgs;
            modules =
            [
                ./home/os

                ./home/packages

                ./home/software

                ./home/system


            ];
            extraSpecialArgs =
            {
                inherit pkgs-stable vars inputs;
            };
        };
    };
}
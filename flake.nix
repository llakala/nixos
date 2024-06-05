{
    description = "A simple NixOS flake";

    inputs =
    {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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
        nixpkgs-unstable,
        home-manager,

        ...
    }:


    let
        vars = import ./variables.nix;
        system = vars.system;
        lib = nixpkgs.lib;

        pkgsArgs = { inherit system; config.allowUnfree = true; };
        pkgs = import nixpkgs pkgsArgs;
        pkgs-unstable = import nixpkgs-unstable pkgsArgs;

    in
    {

        nixosConfigurations.${vars.hostName} = lib.nixosSystem
        {
            modules =
            [

                ./nixos/os

                ./nixos/software

                ./nixos/system

                ./packages/nixos-pkgs.nix
            ];
            specialArgs =
            {
                inherit pkgs-unstable vars inputs;
            };
        };


        homeConfigurations.${vars.username} = home-manager.lib.homeManagerConfiguration
        {
            inherit pkgs;
            modules =
            [
                ./home/os

                ./home/software

                ./home/system

                ./packages/home-pkgs.nix
            ];
            extraSpecialArgs =
            {
                inherit pkgs-unstable vars inputs;
            };
        };
    };
}
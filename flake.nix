{
    description = "A simple NixOS flake";

    inputs =
    {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager =
        {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };


    outputs =
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
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {

        nixosConfigurations.${vars.hostName} = lib.nixosSystem
        {
            modules =
            [

                ./os/nixos

                ./packages/nixos

                ./software/nixos

                ./system/nixos
            ];
            specialArgs =
            {
                inherit pkgs-unstable;
                vars = vars;
            };
        };


        homeConfigurations.${vars.username} = home-manager.lib.homeManagerConfiguration
        {
            inherit pkgs;
            modules =
            [
                ./os/home

                ./packages/home

                ./software/home

                ./system/home


            ];
            extraSpecialArgs =
            {
                inherit pkgs-unstable;
                vars = vars;
            };
        };
    };
}
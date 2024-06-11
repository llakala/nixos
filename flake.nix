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
    }: let

        vars = import ./variables.nix;
        lib = nixpkgs.lib;
        system = "x86_64-linux";

        pkgsArgs = { inherit system; config.allowUnfree = true; };
        pkgs = import nixpkgs pkgsArgs;
        pkgs-stable = import nixpkgs-stable pkgsArgs;

    in
    {
        nixosConfigurations.mypc = nixpkgs.lib.nixosSystem # Desktop as hostname
        {

            inherit system;
            modules =
            [
                ./base/nixos/os
                ./base/nixos/software
                ./base/nixos/system
                ./desktop/nixos
            ];
            specialArgs =
            {
                inherit pkgs-stable vars;
                hostVars = import ./desktop/variables.nix;
            };
        };

        homeConfigurations.mypc = home-manager.lib.homeManagerConfiguration
        {

            inherit pkgs;
            modules =
            [
                ./base/home/os
                ./base/home/software
                ./desktop/home
            ];
            extraSpecialArgs =
            {
                inherit pkgs-stable vars;
                hostVars = import ./desktop/variables.nix;
            };
        };


        nixosConfigurations.framework = nixpkgs.lib.nixosSystem
        {
            inherit system;
            modules =
            [
                ./base/nixos/os
                ./base/nixos/software
                ./base/nixos/system
                ./framework/nixos
            ];
            specialArgs =
            {
                inherit pkgs-stable vars;
                hostVars = import ./desktop/variables.nix;
            };
        };


        homeConfigurations.framework = home-manager.lib.homeManagerConfiguration
        {
            inherit pkgs;
            modules =
            [
                ./base/home/os
                ./base/home/software
                ./framework/home
            ];
            extraSpecialArgs =
            {
                inherit pkgs-stable vars;
                hostVars = import ./desktop/variables.nix;
            };
        };

    };
}

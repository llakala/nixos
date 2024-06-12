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
        vscode-server = 
        {
            url = "github:nix-community/nixos-vscode-server";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-hardware.url = "github:nixos/nixos-hardware/master";


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

        base = import ./base.nix;
    in
    {
        nixosConfigurations.mypc = nixpkgs.lib.nixosSystem # Desktop as hostname
        {
            inherit system;
            modules = lib.concatLists # Combine base config and host config
            [
                base.nix.modules
                [
                    ./desktop/nixos
                    vscode-server.nixosModules.home
                ]
            ];
            specialArgs =
            {
                inherit pkgs-stable vars;
                hostVars = import ./desktop/deskVars.nix;
            };
        };

        homeConfigurations."username@mypc" = home-manager.lib.homeManagerConfiguration
        {
            inherit pkgs;
            modules = lib.concatLists
            [
                base.home.modules
            ];
            extraSpecialArgs =
            {
                inherit pkgs-stable vars;
                hostVars = import ./desktop/deskVars.nix;
            };
        };

        nixosConfigurations.framework = nixpkgs.lib.nixosSystem
        {
            inherit system;
            modules = lib.concatLists
            [
                base.nix.modules
                [
                    ./framework/nixos
                    nixos-hardware.nixosModules.framework-13-7040-amd
                ]
            ];
            specialArgs =
            {
                inherit pkgs-stable vars;
                hostVars = import ./desktop/frameVars.nix;
            };
        };

        homeConfigurations."emanresu@framework" = home-manager.lib.homeManagerConfiguration
        {
            inherit pkgs;
            modules = lib.concatLists
            [
                base.home.modules
            ];
            extraSpecialArgs =
            {
                inherit pkgs-stable vars;
                hostVars = import ./framework/frameVars.nix;
            };
        };

    };
}

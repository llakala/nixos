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
        vscode-server =
        {
            url = "github:nix-community/nixos-vscode-server";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";


    };


    outputs = inputs @
    {
        self,
        nixpkgs,
        nixpkgs-unstable,
        home-manager,
        vscode-server,
        nixos-hardware,
        ...
    }: let

        vars = import ./variables.nix;
        lib = nixpkgs.lib;
        system = "x86_64-linux";

        pkgsArgs = { inherit system; config.allowUnfree = true; };
        pkgs = import nixpkgs pkgsArgs;
        pkgs-unstable = import nixpkgs-unstable pkgsArgs;

        base = import ./base.nix;
    in
    {
        nixosConfigurations.mypc = lib.nixosSystem # Desktop as hostname
        {
            inherit system;
            modules = lib.concatLists # Combine base config and host config
            [
                base.nix.modules
                [
                    ./desktop/nixos
                ]
            ];
            specialArgs =
            {
                inherit pkgs-unstable vars;
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
                inherit pkgs-unstable vars;
                hostVars = import ./desktop/deskVars.nix;
            };
        };

        nixosConfigurations.framework = lib.nixosSystem
        {
            inherit system;
            modules = lib.concatLists
            [
                base.nix.modules
                [
                    ./framework/nixos
                    nixos-hardware.nixosModules.framework-13-7040-amd # Removed until nixos-hardware fixes their stuff
                ]
            ];
            specialArgs =
            {
                inherit pkgs-unstable vars;
                hostVars = import ./framework/frameVars.nix;
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
                inherit pkgs-unstable vars;
                hostVars = import ./framework/frameVars.nix;
            };
        };
    };
}

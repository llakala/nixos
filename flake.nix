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
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";


    };


    outputs = inputs @
    {
        self,
        nixpkgs,
        nixpkgs-unstable,
        home-manager,
        nixos-hardware,
        ...
    }: let

        vars = import ./variables.nix;
        lib = nixpkgs.lib;
        system = "x86_64-linux";

        pkgsArgs = { inherit system; config.allowUnfree = true; };
        pkgs = import nixpkgs commonArgs;
        pkgs-unstable = import nixpkgs-unstable commonArgs;

        base = import ./base.nix;
    in
    {
        nixosConfigurations.mypc = lib.nixosSystem # Desktop as hostname
        {
            inherit pkgs;
            modules = lib.concatLists # Combine base config and host config
            [
                base.nix.modules
                [ ./desktop/nixos ]
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
                [ ./desktop/home ]
            ];
            extraSpecialArgs =
            {
                inherit pkgs-unstable vars;
                hostVars = import ./desktop/deskVars.nix;
            };
        };

        nixosConfigurations.framework = lib.nixosSystem
        {
            inherit pkgs;
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
                [ ./framework/home ]
            ];
            extraSpecialArgs =
            {
                inherit pkgs-unstable vars;
                hostVars = import ./framework/frameVars.nix;
            };
        };
    };
}

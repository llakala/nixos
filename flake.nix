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
        system = "x86_64-linux";
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
        nixosConfigurations =
        {
            mypc = lib.nixosSystem
            {
                inherit system;
                modules =
                [
                    ./config/configuration.nix

                    ./packages/nixos-pkgs.nix

                    ./modules/nixos/bootloader.nix
                    ./modules/nixos/gnome.nix
                    ./modules/nixos/networking.nix
                    ./modules/nixos/nvidia.nix
                    ./modules/nixos/sound.nix
                ];
                specialArgs =
                {
                    inherit pkgs-unstable;
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
                    ./config/home.nix

                    ./packages/home-pkgs.nix

                    ./home-modules/gnome-extensions.nix
                    ./home-modules/dconf-settings.nix

                    ./programs/bash.nix
                    ./programs/git.nix
                ];
                extraSpecialArgs =
                {
                    inherit pkgs-unstable;
                };
            };
        };
    };
}
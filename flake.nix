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
        options = import ./options.nix;
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.options.${options.system};
        pkgs-unstable = nixpkgs-unstable.legacyPackages.${options.system};
    in
    {
        nixosConfigurations =
        {
            ${options.hostName} = lib.nixosSystem
            {
                modules =
                [
                    ./defaults/nixos-defaults.nix

                    ./packages/nixos.nix

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
            ${options.username} = home-manager.lib.homeManagerConfiguration
            {
                inherit pkgs;
                modules =
                [
                    ./defaults/home-defaults.nix

                    ./apps/bash.nix
                    ./apps/git.nix

                    ./packages/home.nix

                    ./modules/home/gnome-extensions.nix
                    ./modules/home/dconf-settings.nix
                ];
                extraSpecialArgs =
                {
                    inherit pkgs-unstable;
                };
            };
        };
    };
}
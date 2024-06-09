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
        lib = nixpkgs.lib;
        vars = import ./variables.nix

        base = import ./profile.nix { inherit inputs pkgs-stable vars; };

        hostName = import ./secrets/host.nix; # Secret
        hostPath = ./${hostName}/profile.nix;
        host = import hostPath;

        pkgsArgs = { inherit (host) system; config.allowUnfree = true; };
        pkgs = import nixpkgs pkgsArgs;
        pkgs-stable = import nixpkgs-stable pkgsArgs;

    in
    {
        nixosConfigurations.${hostName} =
        {
            let
                baseNix = base.nixos;
                hostNix = host.nixos;
            in
                system = host.system;
                modules = baseNix.modules ++ hostNix.modules;
                packages = baseNix.packages // hostNix.packages;
                args = baseNix.args // hostNix.args;
        };

        homeConfigurations.${hostName} =
        {
            let
                baseHome = baseProfiles.home;
                hostHome = host.home;
            in
                system = host.system;
                modules = baseHome.modules ++ hostHome.modules;
                packages = baseHome.packages // hostHome.packages;
                args = baseHome.args // hostHome.args;
        };
    }
}

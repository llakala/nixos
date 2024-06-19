{
    description = "A simple NixOS flake";

    inputs =
    {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager =
        {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };


        nixos-hardware.url = "github:NixOS/nixos-hardware/master";

        disko =
        {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };


    outputs =
    {
        self,

        nixpkgs,
        nixpkgs-unstable,

        home-manager,

        nixos-hardware,
        disko,
        ...
    } @ inputs:

    let
        vars = import ./variables.nix;
        lib = nixpkgs.lib;
        system = "x86_64-linux";

        pkgsArgs = { inherit system; config.allowUnfree = true; };
        pkgs = import nixpkgs pkgsArgs;
        pkgs-unstable = import nixpkgs-unstable pkgsArgs;

        base = import ./base.nix { inherit disko; };
    in
    {


        nixosConfigurations.desktop = lib.nixosSystem
        {
            inherit pkgs; # Do this to properly send the pkgs we declared

            modules = base.nix.modules ++ # Combine base config and host config
            [
                ./desktop/nixos
            ];
            specialArgs =
            {
                inherit pkgs-unstable vars;
                hostVars = import ./desktop/deskVars.nix;
            };
        };

        homeConfigurations."username@desktop" = home-manager.lib.homeManagerConfiguration
        {
            inherit pkgs;
             modules = base.nix.modules ++ # Combine base config and host config
            [
                ./desktop/home
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
            modules = base.nix.modules ++
            [
                ./framework/nixos
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
            modules = base.home.modules ++ # Combine base config and host config
            [
                ./framework/home
            ];
            extraSpecialArgs =
            {
                inherit pkgs-unstable vars;
                hostVars = import ./framework/frameVars.nix;
            };
        };
    };
}

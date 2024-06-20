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

        base = import ./base.nix { inherit disko nixpkgs pkgs pkgs-unstable vars; };
    in
    {


        nixosConfigurations.desktop = lib.nixosSystem
        {
            inherit system;

            modules = base.nix.modules ++
            [
                ./desktop/nix
                ./desktop/nixware
            ];
            specialArgs = base.specialArgs //
            {
                hostVars = import ./desktop/deskVars.nix;
            };
        };

        homeConfigurations."username@desktop" = home-manager.lib.homeManagerConfiguration
        {
            inherit pkgs;
            modules = base.home.modules ++
            [
                ./desktop/home
                ./deskto
















































































                p/homeware
            ];
            extraSpecialArgs = base.specialArgs //
            {
                hostVars = import ./desktop/deskVars.nix;
            };
        };

        nixosConfigurations.framework = lib.nixosSystem
        {
            inherit system;
            modules = base.nix.modules ++
            [
                ./framework/nix
                ./framework/nixware

            ];
            specialArgs = base.specialArgs //
            {
                hostVars = import ./framework/frameVars.nix;
            };
        };
        homeConfigurations."emanresu@framework" = home-manager.lib.homeManagerConfiguration
        {
            inherit pkgs;
            modules = base.home.modules ++
            [
                ./framework/home
                ./framework/homeware
            ];
            extraSpecialArgs = base.specialArgs //
            {
                hostVars = import ./framework/frameVars.nix;
            };
        };
    };
}

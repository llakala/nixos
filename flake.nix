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

        disko =
        {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        firefox-addons =
        {
            url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
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

        disko,

        ...
    }: # Everything else is passed via "inputs.NAME" to avoid clutter

    let
        vars = import ./variables.nix;
        lib = nixpkgs.lib;
        system = "x86_64-linux";

        pkgsArgs = { inherit system; config.allowUnfree = true; };
        pkgs = import nixpkgs pkgsArgs;
        pkgs-unstable = import nixpkgs-unstable pkgsArgs;

        specialArgs = { inherit inputs pkgs-unstable vars; };

        base = import ./base.nix { inherit nixpkgs disko pkgs; };

        mkHosts = import ./mkHosts.nix { inherit lib pkgs inputs pkgs-unstable vars; };
    in
    {

        nixosConfigurations = mkHosts.generateNix "x86_64-linux"
        [
            "desktop"
            "framework"
        ];


        homeConfigurations."username@mypc" = home-manager.lib.homeManagerConfiguration
        {
            inherit pkgs;
            modules = base.home.modules ++
            [
                ./desktop/home
                ./desktop/homeware
            ];
            extraSpecialArgs = specialArgs //
            {
                hostVars = import ./desktop/desktopVars.nix;
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
            extraSpecialArgs = specialArgs //
            {
                hostVars = import ./framework/frameworkVars.nix;
            };
        };
    };
}

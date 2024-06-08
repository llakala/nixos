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
        vars = import ./variables.nix;
        system = vars.system;
        lib = nixpkgs.lib;

        pkgsArgs = { inherit system; config.allowUnfree = true; };
        pkgs = import nixpkgs pkgsArgs;
        pkgs-stable = import nixpkgs-stable pkgsArgs;

        host = import ./secrets/host.nix; # Secret
        { nixBase, homeBase, configMap } = import ./hostProfiles.nix;


        selectConfiguration = type: host: configMap.${host}.${type};

    in 
    {
        nixosConfigurations = 
        {
            "${host}" = 
                let
                    config = selectConfiguration "nixos" host;
                    modules = config.nixBase.modules // config.nixBase.packages;
                    systemExpr = lib.nixosSystem modules config.nixBase.args;
                in
                    lib.optional (configMap ? host) systemExpr;
        };

        homeConfigurations = 
        {
            "${host}" = 
                let
                    config = selectConfiguration "home" host;
                    modules = config.homeBase.modules // config.homeBase.packages;
                    homeExpr = pkgs.lib.homeManagerConfiguration modules config.homeBase.args;
                in
                    lib.optional (configMap ? host) homeExpr;
        };
    }
}
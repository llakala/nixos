{
  description = "A no-longer simple NixOS flake";

  outputs = { self, ... } @ inputs:
  let
    nixpkgs = inputs.nixpkgs;
    lib = nixpkgs.lib;

    # It's a personal repo, not supporting other systems right now
    supportedSystems = lib.singleton "x86_64-linux";

    forAllSystems = function: lib.genAttrs
      supportedSystems
      (system: function nixpkgs.legacyPackages.${system});

    # My custom lib functions, stored in a separate repo.
    # This instance only holds pure functions, and isn't passed
    # to anywhere. We just use it when we need a custom function,
    # but don't have system access.
    pureLlakaLib = inputs.llakaLib.pureLib;

    # All custom lib functions, including system-dependent ones
    # This creates the "main" llakaLib instance once it's passed
    # a system parameter.
    mkLlakaLib = system: inputs.llakaLib.fullLib.${system};

    mkNixos = hostname:
    { system }: let llakaLib = mkLlakaLib system;
    in lib.nixosSystem
    {
      inherit system;

      specialArgs =
      {
        inherit inputs llakaLib self;

        pkgs-unstable = llakaLib.mkPkgs
        {
          inherit system;
          config.allowUnfree = true;
          unpatchedInput = inputs.nixpkgs-unstable;
          patches = [];
        };
      };

      # Use custom function that grabs all files within a folder and filters out non-nix files
      modules = llakaLib.resolveAndFilter
      [
        ./config/core
        ./config/features
        ./config/gnome
        ./config/baseVars.nix

        ./apps/core
        ./apps/programs
        ./apps/shell

        ./hosts/${hostname}/config
        ./hosts/${hostname}/hardware-configuration.nix
        ./hosts/${hostname}/${hostname}Vars.nix

        self.nixosModules.default
      ];
    };

  in
  {
    # Run mkNixos for each host
    nixosConfigurations = builtins.mapAttrs mkNixos
    {
      framework.system = "x86_64-linux";

      desktop.system = "x86_64-linux";
    };

    # Call all packages automatically in directory, while letting packages refer to each other
    # via custom lib function
    packages = forAllSystems
    (
      pkgs: let llakaLib = mkLlakaLib pkgs.system;
      in llakaLib.collectDirectoryPackages
      {
        inherit pkgs;
        directory = ./extras/packages;

        extras = { inherit llakaLib; }; # So custom packages can rely on llakaLib
      }
    );

    # for easier access, this lets us add all our modules by just importing self.nixosModules.default
    nixosModules.default =
    {
      imports = pureLlakaLib.resolveAndFilter
      [
        ./extras/nixosModules
      ];
    };

    formatter = forAllSystems
    (
      pkgs: pkgs.nixfmt-rfc-style
    );
  };


  inputs =
  {
    disko =
    {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    eza-preview-yazi =
    {
      url = "github:ahkohd/eza-preview.yazi/nightly";
      flake = false;
    };

    firefox-addons =
    {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    firefox-gnome-theme =
    {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };

    flake-utils.url = "github:numtide/flake-utils"; # Not actually using this, but we need to pin other things to the same version

    gasp =
    {
      url = "github:llakala/gasp";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.llakaLib.follows = "llakaLib"; # Reuse the same instance, so flake.lock doesn't get ugly
    };

    helix-unstable =
    {
      url = "github:helix-editor/helix"; # Compile Helix from source to support macro keybinds
      inputs.nixpkgs.follows = "nixpkgs-helix"; # So we don't have two instances of `nixpkgs` in flake.lock. We use the same rev from helix's flake.lock so we don't have to recompile
      inputs.flake-utils.follows = "flake-utils";
    };

    home-manager =
    {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = 
    {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    kanagawa-yazi =
    {
      url = "github:dangooddd/kanagawa.yazi";
      flake = false;
    };

    llakaLib =
    {
      url = "github:llakala/llakaLib/purity";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixReadline =
    {
      url = "github:llakala/nix"; # My auto-updating fork of nix that adds readline support
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # Use nixos branches instead of nixpkgs, it runs more tests
    nixpkgs-helix.url = "github:nixos/nixpkgs/bc947f541ae55e999ffdb4013441347d83b00feb"; # Hack for Helix to be able to build tree-sitter
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    rebuild-but-less-dumb =
    {
      url = "github:llakala/rebuild-but-less-dumb";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.llakaLib.follows = "llakaLib"; # Reuse the same instance, so flake.lock doesn't get ugly
    };

    yazi-plugins =
    {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
  };

}

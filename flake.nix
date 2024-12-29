{
  description = "A no-longer simple NixOS flake";

  outputs = { self, ... }:
  let
    myLib = import ./extras/myLib { inherit self; };
  in
  {
    # Run mkNixos for each host
    nixosConfigurations = builtins.mapAttrs myLib.mkNixos
    {
      framework.system = "x86_64-linux";

      desktop.system = "x86_64-linux";
    };

    # Call all packages automatically in directory, while letting packages refer to each other
    # via custom lib function
    packages = myLib.forAllSystems
    (pkgs:
      myLib.selfPackagesFromDirectoryRecursive
      {
        inherit pkgs;
        directory = ./extras/packages;
      }
    );

    nixosModules.default = # for easier access, this lets us add all our modules by just importing self.nixosModules.default
    {
      imports = myLib.resolveAndFilter
      [
        ./extras/nixosModules
      ];
    };

    formatter = myLib.forAllSystems
    (pkgs:
      pkgs.nixfmt-rfc-style
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

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # Use nixos branches instead of nixpkgs, it runs more tests
    nixpkgs-helix.url = "github:nixos/nixpkgs/bc947f541ae55e999ffdb4013441347d83b00feb"; # Hack for Helix to be able to build tree-sitter
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    rebuild-but-less-dumb =
    {
      url = "github:llakala/rebuild-but-less-dumb";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi-plugins =
    {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
  };

}

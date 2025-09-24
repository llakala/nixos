{
  description = "A no-longer simple NixOS flake";

  outputs = args: import ./outputs.nix args;

  inputs = {
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Not actually using this, but we need to pin other things to the same version
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    git-repo-manager = {
      url = "github:hakoerber/git-repo-manager/develop";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    gasp = {
      url = "github:llakala/gasp";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.llakaLib.follows = "llakaLib"; # Reuse the same instance, so flake.lock doesn't get ugly
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kanagawa-yazi = {
      url = "github:dangooddd/kanagawa.yazi";
      flake = false;
    };

    llakaLib = {
      url = "github:llakala/llakaLib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    meovim = {
      url = "github:llakala/meovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    menu = {
      url = "github:llakala/menu";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.llakaLib.follows = "llakaLib"; # Reuse the same instance, so flake.lock doesn't get ugly
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Use nixos branches instead of nixpkgs, it runs more tests
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    systems.url = "github:nix-systems/default";
  };

}

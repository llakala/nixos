{
  description = "A no-longer simple NixOS flake";

  outputs = args: import ./outputs.nix args;

  inputs =
  {
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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.llakaLib.follows = "llakaLib"; # Reuse the same instance, so flake.lock doesn't get ugly
    };

    home-manager =
    {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pinning to commit before recent shell-integration changes
    home-manager-yazi =
    {
      url = "github:nix-community/home-manager/bf9a1a068919ccdfa7d130873936c5fd4c826e85";
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

    lix-module =
    {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    llakaLib =
    {
      url = "github:llakala/llakaLib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    meovim =
    {
      url = "github:llakala/meovim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.flake-utils.follows = "flake-utils";
    };

    menu =
    {
      url = "github:llakala/menu";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.llakaLib.follows = "llakaLib"; # Reuse the same instance, so flake.lock doesn't get ugly
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # Use nixos branches instead of nixpkgs, it runs more tests
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    yazi-plugins =
    {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
  };

}

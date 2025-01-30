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
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.llakaLib.follows = "llakaLib"; # Reuse the same instance, so flake.lock doesn't get ugly
    };

    helix-unstable =
    {
      url = "github:helix-editor/helix"; # Compile Helix from source to support macro keybinds
      inputs.nixpkgs.follows = "nixpkgs-helix"; # Same pin that helix is pinned to, so we get substitutor builds
      inputs.flake-utils.follows = "flake-utils";
    };

    home-manager =
    {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # BRING BACK IF YOU NEED UNSTABLE MODULES
    # home-manager-unstable =
    # {
    #   url = "github:nix-community/home-manager/master";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };

    kanagawa-yazi =
    {
      url = "github:dangooddd/kanagawa.yazi";
      flake = false;
    };

    llakaLib =
    {
      url = "github:llakala/llakaLib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    menu =
    {
      url = "github:llakala/menu";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.llakaLib.follows = "llakaLib"; # Reuse the same instance, so flake.lock doesn't get ugly
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # Use nixos branches instead of nixpkgs, it runs more tests
    nixpkgs-helix.url = "github:nixos/nixpkgs/bc947f541ae55e999ffdb4013441347d83b00feb"; # Hack for Helix to be able to build tree-sitter
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    yazi-plugins =
    {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
  };

}

{
  description = "A no-longer simple NixOS flake";

  outputs = args: import ./outputs.nix args;

  inputs = {
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gasp = {
      url = "github:llakala/gasp";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    meovim = {
      url = "github:llakala/meovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    menu = {
      url = "github:llakala/menu/cleanup"; # TODO: point back to main once PR merged
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Use nixos branches instead of nixpkgs, it runs more tests
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

}

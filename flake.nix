{
  description = "A no-longer simple NixOS flake";

  outputs = args: import ./outputs.nix args;

  inputs =
  {
    firefox-addons =
    {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-gnome-theme =
    {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };

    # Not actually using this, but we need to pin other things to the same version
    flake-utils =
    {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    git-repo-manager =
    {
      url = "github:hakoerber/git-repo-manager/develop";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

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

    # My home-manager fork, which:
    #
    # - points to an older Home-Manager commit, since they didn't backport some lib
    # functions on the latest version, which made overriding the module impossible
    #
    # - Removes the assertions from the module, to prevent IFD
    home-manager-yazi =
    {
      url = "github:llakala/home-manager/fix-yazi-ifd";
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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    meovim =
    {
      url = "github:llakala/meovim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.flake-utils.follows = "flake-utils";
      inputs.llakaLib.follows = "llakaLib";
    };

    menu =
    {
      url = "github:llakala/menu";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.llakaLib.follows = "llakaLib"; # Reuse the same instance, so flake.lock doesn't get ugly
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixcord =
    {
      # Doesn't build unless I pin to this commit
      # See https://github.com/KaylorBen/nixcord/issues/88
      url = "github:kaylorben/nixcord?rev=c1a2a14393dba951994442199b9adfe14bb78a99";

      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # Use nixos branches instead of nixpkgs, it runs more tests
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";

    treefmt-nix =
    {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

}

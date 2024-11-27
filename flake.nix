{
  description = "A no-longer simple NixOS flake";

  inputs =
  {
    disko =
    {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
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

    helix-unstable =
    {
      url = "github:helix-editor/helix/cbbeca6c5227e65bebdbe9abbadbd2202ffc1005"; # Compile Helix from source to support macro keybinds. We don't have it follow nixpkgs so it doesn't recompile all the time
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    home-manager =
    {
      url = "github:nix-community/home-manager/release-24.05";
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

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; # Use nixos branches instead of nixpkgs, it runs more tests
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    rebuild-but-less-dumb =
    {
      url = "github:llakala/rebuild-but-less-dumb/renameEnvVars";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = { self, ... } @ inputs: # Everything is passed via "inputs.NAME" to avoid clutter

  let
    myLib = import ./extras/myLib { inherit self; };

    # Declare nixosConfigurations within the let expression so we can reuse it for homeConfigurations
    nixosConfigurations = builtins.mapAttrs myLib.mkNixos # Run mkNixos for each homeConfiguration, with key passed as host
    {
      framework.system = "x86_64-linux";

      desktop.system = "x86_64-linux";
    };

  in
  {
    packages = myLib.forAllSystems 
    (
      pkgs: import ./extras/packages { inherit myLib pkgs; }
    );

    nixosModules.default = # for easier access, this lets us add all our modules by just importing self.nixosModules.default
    {
      imports = myLib.resolveAndFilter
      [
        ./extras/nixosModules
      ];
    };

    inherit nixosConfigurations;

    homeConfigurations = builtins.mapAttrs myLib.mkHome # Run mkHome for each homeConfiguration, with key passed as userhost
    {
      "emanresu@framework" = { inherit nixosConfigurations; };
    };
  };
}

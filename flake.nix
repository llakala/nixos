{
  description = "A no-longer simple NixOS flake";

  inputs =
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; # Use nixos branches instead of nixpkgs, it runs more tests
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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

    disko =
    {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

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

    kanagawa-yazi =
    {
      url = "github:dangooddd/kanagawa.yazi";
      flake = false;
    };
    helix-unstable.url = "github:helix-editor/helix/7e85fd5b77aa9b0898ddccfb834e36801db31825"; # Compile Helix from source to support macro keybinds. We don't have it follow nixpkgs so it doesn't recompile all the time

    rbld =
    {
      url = "github:llakala/rebuild-but-less-dumb/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = inputs @ { ... }: # Everything is passed via "inputs.NAME" to avoid clutter

  let
    myLib = import ./extras/myLib { inherit inputs; };

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

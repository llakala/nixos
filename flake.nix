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
    disko =
    {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };


  outputs = inputs @
  {
    self,

    nixpkgs,
    nixpkgs-unstable,

    home-manager,
    ...
  }: # Everything else is passed via "inputs.NAME" to avoid clutter

  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";

    pkgsArgs = { inherit system; config.allowUnfree = true; };
    pkgs = import nixpkgs pkgsArgs;
    pkgs-unstable = import nixpkgs-unstable pkgsArgs;

    mkHosts = import ./mkHosts.nix { inherit lib pkgs inputs pkgs-unstable; };
  in
  {

      nixosConfigurations = mkHosts.generateNix
      "x86_64-linux"
      [
          "desktop"
          "framework"
      ];


      homeConfigurations = mkHosts.generateHome
      [
        "username"
        "emanresu"
      ]
      [
        "desktop"
        "framework"
      ];

      devShells.${system}.default = import ./resources/shell.nix { inherit pkgs lib; };

      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux; # For activating home-manager
  };
}

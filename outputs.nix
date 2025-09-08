{ self, nixpkgs, ... } @ inputs:

let
  lib = nixpkgs.lib;

  # I occasionally work on a random mac and need devshell access, so the darwin
  # setup is nice. I don't guarantee any support for rebuilding with
  # aarch64-darwin, though.
  supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];

  forAllSystems = function: lib.genAttrs
    supportedSystems
    (system: function nixpkgs.legacyPackages.${system});

  # My custom lib functions, stored in a separate repo.
  # This instance only holds pure functions, and isn't passed
  # to anywhere. We just use it when we need a custom function,
  # but don't have system access.
  pureLlakaLib = inputs.llakaLib.pureLib;

in {
  nixosConfigurations = import ./hosts.nix { inherit inputs self; };

  # Call all packages automatically in directory, while letting packages refer to each other
  # via custom lib function
  legacyPackages = forAllSystems (pkgs: let
    llakaLib = inputs.llakaLib.fullLib.${pkgs.system};
  in llakaLib.collectDirectoryPackages {
    inherit pkgs;
    directory = ./extras/packages;

    extras = { inherit llakaLib; }; # So custom packages can rely on llakaLib
  });

  # for easier access, this lets us add all our modules by just importing self.nixosModules.default
  nixosModules.default = {
    imports = pureLlakaLib.resolveAndFilter [
      ./extras/nixosModules
    ];
  };

  devShells = forAllSystems (pkgs: {
    default = import ./extras/shell.nix { inherit pkgs inputs; };
  });

  formatter = forAllSystems (pkgs:
    pkgs.nixfmt-rfc-style
  );
}

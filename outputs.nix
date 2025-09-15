{ self, nixpkgs, ... } @ inputs:

let
  lib = nixpkgs.lib;

  # I occasionally work on a random mac and need devshell access, so the darwin
  # setup is nice. I don't guarantee any support for rebuilding with
  # aarch64-darwin, though.
  supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];

  # Parameterize system. I give access to both `pkgs` and my custom lib
  # functions, but can ignore one/both depending on what each output needs.
  forAllSystems = unappliedOutput: lib.genAttrs supportedSystems (
    system: unappliedOutput
      nixpkgs.legacyPackages.${system}
      inputs.llakaLib.fullLib.${system}
  );

  # Separate instance of llakaLib, which only holds pure functions (aka nothing
  # dependent on system). Most functions are in this set, so this is useful when
  # I'm in an environment without system access
  pureLlakaLib = inputs.llakaLib.pureLib;

in {
  nixosConfigurations = import ./hosts.nix { inherit inputs self; };

  # Call all packages automatically in directory, while letting packages refer
  # to each other via custom lib function
  legacyPackages = forAllSystems (pkgs: llakaLib:
    llakaLib.collectDirectoryPackages {
      inherit pkgs;
      directory = ./extras/packages;

      # So custom packages can rely on llakaLib. We need to use the full version
      # here, since I have some functions like `writeFishApplication`, that need
      # `pkgs` to function.
      extras = { inherit llakaLib; };
    }
  );

  # for easier access, this lets us add all our modules by just importing
  # self.nixosModules.default
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

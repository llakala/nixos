{ self, nixpkgs, ... } @ inputs:

let
  lib = nixpkgs.lib;

  # I occasionally work on a random mac and need devshell access, so the darwin
  # setup is nice. I don't guarantee any support for rebuilding with
  # aarch64-darwin, though.
  supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];

  forAllSystems = apply: lib.genAttrs supportedSystems (system: let
    pkgs = nixpkgs.legacyPackages.${system};
    myLib = import ./various/myLib/default.nix { inherit pkgs; };
  in apply pkgs myLib);

in {
  nixosConfigurations = import ./hosts.nix { inherit inputs self; };

  # Call all packages automatically in directory, while letting packages refer
  # to each other via custom lib function
  legacyPackages = forAllSystems (pkgs: myLib: myLib.mkPackageSet {
    filepaths = {
      emodule = ./various/packages/emodule.nix;
      evalue = ./various/packages/evalue.nix;
      git-repo-manager = ./various/packages/git-repo-manager.nix;
      jc = ./various/packages/jc.nix;
      kittab = ./various/packages/kittab.nix;
    };
    extras = { inherit myLib; };
  });

  devShells = forAllSystems (pkgs: _: {
    default = pkgs.mkShellNoCC {
      packages = builtins.attrValues {
        inherit (pkgs)
          fish
          yazi
          git
          kitty
          gh
          erlang
          gleam
          rebar3
          elixir;

        nvim = inputs.meovim.packages.${pkgs.system}.default;

        inherit (inputs.menu.legacyPackages.${pkgs.system})
          rbld
          unify
          fuiska;

        inherit (inputs.gasp.legacyPackages.${pkgs.system})
          ghp
          gfp
          gkp;
      };
    };
  });

  formatter = forAllSystems (pkgs: _: pkgs.nixfmt-rfc-style);
}

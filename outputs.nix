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

  legacyPackages = forAllSystems (pkgs: myLib:
    let
      callPackage = lib.callPackageWith (pkgs // { inherit myLib; });
    in {
      emodule = callPackage ./various/packages/emodule.nix {};
      evalue = callPackage ./various/packages/evalue.nix {};
      git-repo-manager = callPackage ./various/packages/git-repo-manager.nix {};
      jc = callPackage ./various/packages/jc.nix {};
      kittab = callPackage ./various/packages/kittab.nix {};
    }
  );

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

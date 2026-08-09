{
  sources ? import ../other/npins,
  pkgs ? import sources.nixpkgs { config.allowUnfree = true; },
  myLib ? import ../other/myLib/default.nix { inherit pkgs; },
  wrappers ? import ../wrappers { inherit pkgs sources myLib; }
}:

let
  inherit (pkgs) lib;
  callPackage = lib.callPackageWith (
    pkgs
    // {
      inherit myLib wrappers;
      localPackages = packages;
    }
  );
  packages = {
    neovim = callPackage ../neovim/default.nix { inherit sources; };
    emodule = callPackage ./emodule.nix {};
    evalue = callPackage ./evalue.nix {};
    mathematica = callPackage ./mathematica.nix {};
    gps = callPackage ./gps/package.nix {};
    satod = callPackage ./satod/package.nix {};
    sadin = callPackage ./sadin/package.nix {};
  };
in packages

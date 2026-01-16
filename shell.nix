{
  sources ? import ./various/npins,
  pkgs ? import sources.nixpkgs {},
  myLib ? import ./various/myLib/default.nix { inherit pkgs; }
}:

let
  menu = import "${sources.menu}/packages/default.nix" { inherit pkgs; };
  meovim = import "${sources.meovim}/default.nix" {
    small = false;
    inherit pkgs;
    mnw = import sources.mnw;
    neovim = sources.neovim { inherit pkgs; }; # We use a derivation fetcher here to avoid ever refetching
  };
  packages = import ./packages.nix { inherit sources pkgs myLib; };
  wrappers = import ./wrappers { inherit sources pkgs myLib; };
in
pkgs.mkShellNoCC {
  allowSubstitutes = false;

  packages = [
    meovim
    wrappers.firefox.drv
    wrappers.gh.drv
    wrappers.git.drv
    wrappers.kittab.drv
    wrappers.yazi.drv
    wrappers.fish.drv
    wrappers.less.drv
    wrappers.bat.drv
    packages.satod
    packages.evalue
    menu.imanpu
  ];
}

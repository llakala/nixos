{
  sources ? import ./various/npins,
  pkgs ? import sources.nixpkgs { },
  myLib ? import ./various/myLib/default.nix { inherit pkgs; }
}:

let
  menu = import "${sources.menu}/packages/default.nix" { inherit pkgs; };
  meovim = import "${sources.meovim}/default.nix" { inherit pkgs; mnw = import sources.mnw; };
  packages = import ./packages.nix { inherit sources pkgs myLib; };
  wrappers = import ./wrappers { inherit sources pkgs myLib; };

in
pkgs.mkShellNoCC {
  packages = [
    meovim
    wrappers.firefox.drv
    wrappers.gh.drv
    wrappers.git.drv
    wrappers.kittab.drv
    wrappers.yazi.drv
    packages.satod
    packages.evalue
    menu.imanpu
    pkgs.fish
  ];
}

{
  sources ? import ./other/npins,
  pkgs ? import sources.nixpkgs { config.allowUnfree = true; },
  myLib ? import ./other/myLib/default.nix { inherit pkgs; }
}:

let
  menu = import "${sources.menu}/packages/default.nix" { inherit pkgs; };
  packages = import ./packages { inherit sources pkgs myLib wrappers; };
  wrappers = import ./wrappers { inherit sources pkgs myLib; };
in
pkgs.mkShellNoCC {
  allowSubstitutes = false;
  packages = [
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
    packages.neovim
    menu.imanpu
  ];
}

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
    wrappers.firefox.result
    wrappers.gh.result
    wrappers.git.result
    wrappers.kittab.result
    wrappers.yazi.result
    wrappers.fish.result
    wrappers.less.result
    wrappers.bat.result
    (wrappers.neovim.call { devMode = true; })
    packages.satod
    packages.evalue
    menu.imanpu
  ];
}

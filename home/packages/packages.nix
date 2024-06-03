{
  pkgs,
  pkgs-stable,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  home.packages =
  (with pkgs;
  [
    firefox
    vscode
    discord
    gparted
  ])
  ++

  (with pkgs-stable;
  [

  ]);


}
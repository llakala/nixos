{
  pkgs,
  pkgs-stable,
  ...
}:

{

  home.packages =

  (with pkgs-stable;
  [
    discord
    gparted
  ])
  ++

  (with pkgs;
  [
    firefox
    vscode
  ]);


}
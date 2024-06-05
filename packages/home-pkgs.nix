{
  pkgs,
  pkgs-unstable,
  ...
}:

{

  home.packages =

  (with pkgs;
  [
    discord
    gparted
    modrinth-app
  ])
  ++

  (with pkgs-unstable;
  [
    firefox
    vscode
  ]);


}
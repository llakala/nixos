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
    filezilla
    modrinth-app

  ])
  ++

  (with pkgs-unstable;
  [
    vscode
  ]);


}
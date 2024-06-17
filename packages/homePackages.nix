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
    firefox-org
    filezilla
    modrinth-app

  ])
  ++

  (with pkgs-unstable;
  [
    vscode
  ]);


}
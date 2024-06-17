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
    firefox-org # firefox on xorg
    filezilla
    modrinth-app

  ])
  ++

  (with pkgs-unstable;
  [
    vscode
  ]);


}
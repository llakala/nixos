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
    moonlight-qt

  ])
  ++

  (with pkgs-unstable;
  [

  ]);


}
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
    moonlight-qt
    viewnior # image viewer
  ])
  ++

  (with pkgs-unstable;
  [

  ]);


}
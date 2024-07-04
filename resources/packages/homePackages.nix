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
    zathura # pdf viewer
    viewnior # image viewer
  ])
  ++

  (with pkgs-unstable;
  [

  ]);


}
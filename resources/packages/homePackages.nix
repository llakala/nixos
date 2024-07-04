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
    zathura
    viewnior
  ])
  ++

  (with pkgs-unstable;
  [

  ]);


}
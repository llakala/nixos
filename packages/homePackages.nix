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
  ])
  ++

  (with pkgs-unstable;
  [

  ]);


}
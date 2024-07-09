{
  pkgs-unstable,
  pkgs,
  ...
}:


{

  environment.systemPackages =
  (with pkgs;
  [
    webcord # Discord client
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
{
  pkgs-unstable,
  pkgs,
  ...
}:


{

  environment.systemPackages =
  (with pkgs;
  [
    webcord
    gparted
    filezilla
    moonlight-qt
    viewnior # image viewer
  ])
  ++
  (with pkgs-unstable;
  [
    vscode
    zathura
  ]);

  programs =
  {
    firefox.enable = true;
  };
}
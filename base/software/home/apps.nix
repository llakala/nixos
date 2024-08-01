{
  pkgs-unstable,
  pkgs,
  ...
}:


{

  home.packages =
  with pkgs;
  [
    modrinth-app
    webcord # Discord client
    gparted
    filezilla
    moonlight-qt
    viewnior # image viewer

    virt-manager
    spotify
  ];
}
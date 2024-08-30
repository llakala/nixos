{
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
    spotify
    shortwave # Internet radio
  ];
}
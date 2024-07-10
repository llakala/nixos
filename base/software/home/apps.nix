{
  pkgs-unstable,
  pkgs,
  ...
}:


{

  home.packages =
  with pkgs;
  [
    webcord # Discord client
    gparted
    filezilla
    moonlight-qt
    viewnior # image viewer

    slack
    atlassian-jira

    spotify
  ];
}
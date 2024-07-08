{
  pkgs-unstable,
  pkgs,
  ...
}:


{

  environment.systemPackages =
  with pkgs;
  [
    webcord
    gparted
    filezilla
    moonlight-qt
    viewnior # image viewer
  ];

  programs = 
  {
    bash.enable = true;
    firefox.enable = true;
    git.enable = true;
    vscode.enable = true;
    zathura.enable = true;
  };
}
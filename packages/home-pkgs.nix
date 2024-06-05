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
    modrinth-app
    filezilla
  ])
  ++

  (with pkgs-unstable;
  [
    firefox
    vscode
  ]);


}
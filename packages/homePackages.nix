{
  pkgs,
  pkgs-stable,
  ...
}:

{

  home.packages =

  (with pkgs-stable;
  [
    discord
    gparted
    modrinth-app
    filezilla
  ])
  ++

  (with pkgs;
  [
    firefox
    vscode
  ]);


}
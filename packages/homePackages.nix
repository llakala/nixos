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
    filezilla
  ])
  ++

  (with pkgs;
  [
    firefox
    vscode
  ]);


}
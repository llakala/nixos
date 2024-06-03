{
  pkgs,
  pkgs-stable,
  ...
}:

{

  
  home.packages =
  (with pkgs;
  [
    firefox
    vscode
    discord
    gparted
  ])
  ++

  (with pkgs-stable;
  [
    modrinth-app
  ]);


}
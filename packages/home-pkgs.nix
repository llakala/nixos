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
    prismlauncher
  ])
  ++

  (with pkgs-unstable;
  [
    firefox
    vscode
  ]);


}
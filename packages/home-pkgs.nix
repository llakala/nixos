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
    prismlauncher
  ])
  ++

  (with pkgs;
  [
    firefox
    vscode
  ]);


}
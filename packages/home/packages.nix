{ pkgs }:

{

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs;
  [
    firefox
    vscode
    usbimager
    pika-backup
  ];
}
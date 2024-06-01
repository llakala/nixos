{
  pkgs,
  inputs,
  system,
  vars,
  ...
}:

{

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs;
  [
    firefox
    vscode
    usbimager
    pika-backup
    discord
    inputs.nix-software-center.packages.${vars.system}.nix-software-center
  ];
}
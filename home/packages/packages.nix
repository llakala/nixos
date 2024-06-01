{
  pkgs,
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
    inputs.nix-software-center.packages.${system}.nix-software-center
  ];
}
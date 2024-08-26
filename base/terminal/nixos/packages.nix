{
  pkgs,
  lib,
  ...
}:

let
  basic = with pkgs;
  [
    coreutils # Basic linux utils
    libgccjit # gcc
    usbutils
    bind # Networking utils
  ];

  commands = with pkgs;
  [
    ripgrep
    gnumake # Make
    unzip
    wget

    jq
  ];

  nixUtils = with pkgs;
  [
    nil # Nix language server
    nvd
    nix-output-monitor # NOT CALLED NOM
  ];

  programming = with pkgs;
  [
    nodejs
    jdk
  ];

  linux = with pkgs;
  [
    grub2
    grub2_efi
    efibootmgr

    appimage-run # Allow running appimages for when something isnt on nixpkgs
  ];

  extras = with pkgs;
  [
    # Secrets
    age
    ssh-to-age
    libsecret

    hwinfo

    xorg.xeyes # Check if app is running in xwayland or wayland
  ];
in
{
  environment.systemPackages = lib.concatLists
  [
    basic
    commands
    nixUtils
    programming
    linux
    extras
  ];
}
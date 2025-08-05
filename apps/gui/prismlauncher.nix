{ lib, pkgs, ... }:

let
  # The default also includes jdk8 and jdk17 for old mc versions - but if
  # I'm pulling up the game, it's probably just to try out a snapshot
  myPrism = pkgs.prismlauncher.override {
    jdks = with pkgs; [
      jdk21
    ];
  };

in {
  environment.systemPackages = lib.singleton myPrism;
}

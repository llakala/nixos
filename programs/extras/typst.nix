{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.typst
  ];
}

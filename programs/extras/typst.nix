{ pkgs, ... }:

{
  features.math = "typst";
  environment.systemPackages = [
    pkgs.typst
  ];
}

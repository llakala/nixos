{ pkgs, ... }:

let
  myRPackages = with pkgs.rPackages;
  [
    quarto
  ];
in
{
  environment.systemPackages = with pkgs;
  [
    R
    rstudio
  ] ++ myRPackages;
}

{ pkgs,  ... }:

{

  environment.systemPackages = with pkgs;
  [
    man
  ];

  documentation.man.generateCaches = true; # Needed to make whatis work
}
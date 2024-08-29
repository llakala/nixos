{ pkgs, ... }:

{

   environment.systemPackages = with pkgs; [ python313 ] ++
   (with pkgs.python313Packages;
   [
      # pandas # Relies on numpy
      # numpy # Broken on 3.13
      # matplotlib # Relies on numpy
  ]);
}
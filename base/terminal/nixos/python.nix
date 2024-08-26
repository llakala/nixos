{ pkgs, ... }:

{

   environment.systemPackages = with pkgs; [ python311 ] ++
   (with pkgs.python311Packages;
   [
      pandas
      matplotlib
      numpy
  ]);
}
{ pkgs-unstable, pkgs, ... }:

let
   myPython = pkgs.python3; # Python version for our packages to reference

   myPythonPackages = pythonPackages: with pythonPackages;
   [
      termcolor
      pandas
      matplotlib
      numpy
   ];
in
{
   environment.systemPackages =
   [
      ( myPython.withPackages myPythonPackages )
   ];
}
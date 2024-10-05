{ pkgs-unstable, pkgs, ... }:

let
   myPython = pkgs.python3;

   myPythonPackages = pythonPackages: with pythonPackages;
   [
      termcolor
      pandas
      matplotlib
      numpy
   ];
in
{
   environment.systemPackages = [( myPython.withPackages myPythonPackages )];
}
{ pkgs, ... }:

let
   myPython = pkgs.python312;

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
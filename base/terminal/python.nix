{ pkgs-unstable, ... }:

let
   myPython = pkgs-unstable.python313;

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
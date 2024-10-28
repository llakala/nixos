{ pkgs, lib, ... }:

let
   myPython = pkgs.python3; # Python version for our packages to reference

   myPythonPackages = pythonPackages: with pythonPackages;
   [
      termcolor
      pandas
      matplotlib
      numpy
      pycodestyle
      pretty-errors
      pip # Just for use in virtual environments, systemwide-packages should be put here
   ];
in
{
   environment.systemPackages = lib.singleton
   ( myPython.withPackages myPythonPackages );

   environment.shellAliases.pep8 = "pycodestyle";

}

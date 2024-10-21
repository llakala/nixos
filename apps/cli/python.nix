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
   ];
in
{
   environment.systemPackages = lib.singleton
   ( myPython.withPackages myPythonPackages );

   environment.shellAliases.pep8 = "pycodestyle";

}

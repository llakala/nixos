{ pkgs, lib, ... }:

let

   # Python version for our packages to reference
   myPython = pkgs.python3;

   myPythonPackages = pythonPackages: with pythonPackages;
   [
      pandas
      matplotlib
      numpy

      termcolor
      pretty-errors

      pycodestyle
      pretty-errors

      pip
   ];
in
{
   environment.systemPackages = lib.singleton
   ( 
      myPython.withPackages myPythonPackages 
   );

   environment.shellAliases.pep8 = "pycodestyle";

   environment.variables =
   {
      # For non virtual environments, we should use Nix
      PIP_REQUIRE_VIRTUALENV = "true";
   };

}

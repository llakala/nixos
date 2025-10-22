{ pkgs, lib, ... }:

let
  myPythonPackages = pythonPackages: with pythonPackages; [
    pandas
    matplotlib
    numpy
    termcolor
    pretty-errors
    pycodestyle
    pip
  ];
in {
  environment.systemPackages = lib.singleton (pkgs.python3.withPackages myPythonPackages);

  environment.shellAliases.pep8 = "pycodestyle";

  environment.variables = {
    PIP_REQUIRE_VIRTUALENV = "true"; # For non virtual environments, we should use Nix
  };
}

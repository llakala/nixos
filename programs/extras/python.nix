{ pkgs, ... }:

let
  myPythonPackages = pythonPackages: with pythonPackages; [
    pycodestyle
    pip
  ];
in {
  environment.systemPackages = [
    (pkgs.python3.withPackages myPythonPackages)
  ];

  environment.shellAliases.pep8 = "pycodestyle";

  environment.variables = {
    PIP_REQUIRE_VIRTUALENV = "true"; # For non virtual environments, we should use Nix
  };
}

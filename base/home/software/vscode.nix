{ pkgs-unstable, ... }:
{

  programs.vscode =
  {

    package = pkgs-unstable.vscode;
  };

}
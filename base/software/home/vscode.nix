{ pkgs-unstable, ... }:
{

  home.sessionVariables =
  {
    NIXOS_OZONE_WL = "1";
  };

  programs.vscode =
  {
    enable = true;

    package = pkgs-unstable.vscode;
  };

}
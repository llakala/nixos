{ pkgs, ... }:

{

  programs.java =
  {
    enable = true;
    package = pkgs.jdk17;
  };

  environment.systemPackages = with pkgs;
  [
    gradle
    babelfish # Seems to be required for java setup
  ];
}

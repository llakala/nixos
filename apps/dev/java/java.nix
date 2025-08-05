{ pkgs, ... }:

{
  programs.java =
  {
    enable = true;
  };

  environment.systemPackages = with pkgs;
  [
    gradle
    babelfish # Seems to be required for java setup
  ];
}

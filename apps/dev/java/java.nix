{ pkgs, lib, ... }:

let
  # Gives me better features over jdk17 version, like arrow key support
  # We need to wrap it in writeShellScriptBin to add it to `sytemPackages`
  # Otherwise it's just a path
  myJshell = pkgs.writeShellScriptBin
    "jshell"
    (lib.getExe' pkgs.jdk23 "jshell");

in
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
  ] ++ lib.singleton myJshell;
}

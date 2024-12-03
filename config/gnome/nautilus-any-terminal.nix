{ pkgs, ... }:

{

  programs.nautilus-open-any-terminal =
  {
    enable = true;
    terminal = "kitty";
  };

  # Need these until 24.11 comes out with my PR https://github.com/NixOS/nixpkgs/pull/342104
  environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";
  environment.pathsToLink = [ "/share/nautilus-python/extensions" ];


}

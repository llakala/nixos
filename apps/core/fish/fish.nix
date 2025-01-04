{ pkgs, ... }:
{
  programs.command-not-found.enable = false; # Broken

  users.defaultUserShell = pkgs.fish;
  programs.fish =
  {
    enable = true;
    useBabelfish = true; # Important: halves the startup time
  };

  hm.programs.fish =
  {
    enable = true;
  };
  hm.xdg.configFile."fish/config.fish".force = true;

  hm.programs.fish.shellInit =
  /* fish */
  ''
     # THIS WAS AN AWFUL HEADACHE, ENSURE YOU SET THE MODE
    bind -M insert \t accept-autosuggestion
    bind -M insert -k nul complete-and-search

    set fish_greeting
  '';
}
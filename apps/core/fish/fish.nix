{ pkgs, ... }:

{

  programs.fish =
  {
    enable = true;
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

  hm.programs.fish.interactiveShellInit =
  /* fish */
  ''
    fish_vi_key_bindings
  '';

}
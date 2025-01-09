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
    set fish_greeting

    set fish_cursor_default     block      blink
    set fish_cursor_insert      line       blink
    set fish_cursor_replace_one underscore
    set fish_cursor_visual      underscore blink
  '';

  hm.programs.fish.functions.fish_title = "prompt_pwd -d 0"; # Somehow seems to be necessary for kitty to obey us
}
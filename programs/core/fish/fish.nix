{ pkgs, ... }:

{
  features.shell = "fish"; # If we ever stop using Fish, change this

  programs.command-not-found.enable = false; # Broken

  users.defaultUserShell = pkgs.fish;
  programs.fish = {
    enable = true;
    useBabelfish = true; # Important: halves the startup time
  };

  hm.programs.fish.enable = true;
  hm.xdg.configFile."fish/config.fish".force = true;

  hm.programs.fish.interactiveShellInit = # fish
  ''
    set fish_greeting

    set fish_cursor_default     block      blink
    set fish_cursor_insert      line       blink
    set fish_cursor_replace_one underscore
    set fish_cursor_visual      underscore blink

    # Rewriting the fish_title function to print the full prompt_pwd. Sourced from:
    # https://github.com/fish-shell/fish-shell/blob/945a53/share/functions/fish_title.fish#L8
    # Note that this doesn't seem to work properly. May be a kitty issue
    function fish_title
      if set -q argv[1]
        echo -- (string sub -l 20 -- $argv[1]) (prompt_pwd)

      else
        set -l command (status current-command)

        if [ $command = fish ]
          set command
        end

        echo -- (string sub -l 20 -- $command) (prompt_pwd)
      end
    end
  '';
}

{ lib, ... }:

{
  hm.programs.starship =
  {
    enable = true;
  };

  hm.programs.starship.settings =
  {
    line_break.disabled = true; # Everything on one line
    palette = "custom";
    directory.truncate_to_repo = false; # Show full path of current directory

    character =
    {
      success_symbol = "[❯](bold green)";
      error_symbol = "[✗](bold red)";
      vimcmd_symbol = "[❮](bold blue)";
    };

    palettes.custom = # To add new colors, or change existing ones
    {
      pink = "#ea76cb";
      orange = "#ff8800";
    };

    git_status =
    {
      modified = "M";
      staged = "S";
      untracked = "A";
      renamed = "R";
      deleted = "D";
      conflicted = "U";
      stashed = "";

      ahead = "+$count";
      behind = "-$count";
      diverged = "+$ahead_count-$behind_count";

      # Referenced from https://github.com/clotodex/nix-config/blob/c878ff5d5ae674b49912387ea9253ce985cbd3cd/shell/starship.nix#L82
      format = lib.concatStrings
      [
        "["

        "(\\["
          "[($conflicted)](orange)"
          "[($stashed)](white)"
          "[($staged)](blue)"
          "[($deleted)](red)"
          "[($renamed)](yellow)"
          "[($modified)](yellow)"
          "[($untracked)](green)"
        "\\])"

        "( \\[$ahead_behind\\])"

        "]"
        "($style) "
      ];

      style = "white";
      disabled = false;
    };

    # git_status.format = lib.concatStrings
    # [
    #   "[($conflicted )](red)"
    #   "[($staged )](green)"
    #   "[($deleted )](red)"
    #   "[($renamed )](blue)"
    #   "[($modified )](yellow)"
    #   "[($untracked )](blue)"
    #   "[($ahead_behind )](green)"
    # ];

    git_branch.ignore_branches = [ "master" "main" ]; # Don't show git branch if on master/main

    cmd_duration.min_time = 30 * 1000; # 30 seconds

    battery.display = lib.singleton
    {
      threshold = 10;
    };

  };
}
{ lib, ... }:

{
  hm.programs.starship =
  {
    enable = true;
  };

  hm.programs.starship.settings =
  {
    line_break.disabled = true; # Everything on one line

    directory.truncate_to_repo = false; # Show full path of current directory

    character =
    {
      success_symbol = "[❯](bold green)";
      error_symbol = "[✗](bold red)";
      vimcmd_symbol = "[❮](bold blue)";
    };

    git_status =
    {
      modified = "[M](yellow)";
      staged = "[S](blue)";
      untracked = "[A](grey)";
      renamed = "R";
      deleted = "[D](red)";

      stashed = "";

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
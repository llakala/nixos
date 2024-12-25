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
    git_branch.ignore_branches = [ "master" "main" ]; # Don't show git branch if on master/main

    cmd_duration.min_time = 30 * 1000; # 30 seconds

    battery.display = lib.singleton
    {
      threshold = 10;
    };

  };
}
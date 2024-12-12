{ lib, ... }:

{
  hm.programs.starship =
  {
    enable = true;
  };

  hm.programs.starship.settings =
  {
    directory.truncate_to_repo = false; # Show full path of current directory

    git_branch.ignore_branches = [ "master" "main" ]; # Don't show git branch if on master/main

    cmd_duration.min_time = 30 * 1000; # 30 seconds

    line_break.disabled = true; # Everything on one line

    battery.display = lib.singleton
    {
      threshold = 5;
    };

  };
}
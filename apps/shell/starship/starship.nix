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

    battery.display = lib.singleton
    {
      threshold = 10;
    };
  };


  hm.programs.starship.settings.time =
  {
    disabled = false;
    time_format = "%I:%M %p"; # 9:47 PM
  };


  hm.programs.starship.settings.character =
  {
    success_symbol = "[❯](bold green)";
    error_symbol = "[✗](bold red)";
    vimcmd_symbol = "[❮](bold blue)";
  };


  hm.programs.starship.settings.cmd_duration =
  {
    min_time = 30 * 1000; # 30 seconds
    format = "[  $duration ]($style)"; # Character is a clock symbol
  };


  hm.programs.starship.settings.fill =
  {
    symbol = "─";
    style = "fg:fill";
  };

}
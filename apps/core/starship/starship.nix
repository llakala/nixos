{ lib, ... }:

{
  # If we ever stop using Starship, change this
  features.prompt = "starship";

  hm.programs.starship =
  {
    enable = true;
  };

  hm.programs.starship.settings =
  {
    # Show full path of current directory
    directory.truncate_to_repo = false;

    # Don't show git branch if on master/main
    git_branch.ignore_branches = [ "master" "main" ];

    battery.display = lib.singleton
    {
      threshold = 10;
    };
  };


  hm.programs.starship.settings.time =
  {
    disabled = false;

    # 9:47 PM
    time_format = "%I:%M %p";
  };


  hm.programs.starship.settings.character =
  {
    success_symbol = "[❯](bold green)";
    error_symbol = "[✗](bold red)";
    vimcmd_symbol = "[❮](bold blue)";
  };


  hm.programs.starship.settings.cmd_duration =
  {
    # 30 seconds
    min_time = 30 * 1000;

    # Character is a clock symbol
    format = "[  $duration ]($style)";
  };


  hm.programs.starship.settings.fill =
  {
    symbol = "─";
    style = "fg:fill";
  };

  hm.programs.starship.settings.direnv =
  {
    disabled = false;

    # Remove the slash
    format = "[$loaded]($style)";

    loaded_msg = "";
    unloaded_msg = "UNLOADED";
  };

}

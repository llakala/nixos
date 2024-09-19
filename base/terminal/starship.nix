{ ... }:

{
  hm =
  {

    programs.starship =
    {
      enable = true;
      enableZshIntegration = true;
    };

    programs.starship.settings.directory =
    {
      truncate_to_repo = false; # Show full path of current direcotry
    };

    programs.starship.settings.git_branch =
    {
      ignore_branches = [ "master" "main" ]; # Don't show git branch if on master/amin
    };

    programs.starship.settings.cmd_duration =
    {
      min_time = 30 * 1000; # 30 seconds
    };

    programs.starship.settings.line_break =
    {
      disabled = true; # Everything on one line
    };

    programs.starship.settings.battery =
    {
      display = # TODO: Use the lib wrapper function here
      [{
        threshold = 5;
      }];
    };
  };
}
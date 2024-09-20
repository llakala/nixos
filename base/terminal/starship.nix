{ ... }:

{
  hm.programs.starship =
  {
    enable = true;
    enableZshIntegration = true;

    settings.directory =
    {
      truncate_to_repo = false; # Show full path of current direcotry
    };

    settings.git_branch =
    {
      ignore_branches = [ "master" "main" ]; # Don't show git branch if on master/amin
    };

    settings.cmd_duration =
    {
      min_time = 30 * 1000; # 30 seconds
    };

    settings.line_break =
    {
      disabled = true; # Everything on one line
    };

    settings.battery =
    {
      display = # TODO: Use the lib wrapper function here
      [{
        threshold = 5;
      }];
    };
  };
}
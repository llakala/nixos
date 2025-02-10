{ lib, ... }:

{
  hm.programs.starship.settings.format = lib.concatStrings
  [
    "$all" # Everything not specified below
    "$direnv" # TODO: find out why this isn't working, and it's still on the right
    "$git_branch"

    "$fill"

    "$cmd_duration"
    "$time"
    "$line_break"
    "$character"
  ];

}

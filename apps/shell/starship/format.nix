{ lib, ... }:

{
  hm.programs.starship.settings.format = lib.concatStrings
  [
    "$all" # Everything not specified below
    "$git_branch"

    "$fill"

    "$cmd_duration"
    "$time"
    "$line_break"
    "$character"
  ];

}
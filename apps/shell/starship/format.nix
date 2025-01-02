{ lib, ... }:

{
  hm.programs.starship.settings.format = lib.concatStrings
  [
    "$all" # Everything not specified below

    "$fill"

    "$cmd_duration"
    "$git_branch"
    "$time"
    "$line_break"
    "$character"
  ];

}
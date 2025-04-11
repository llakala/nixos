{ lib, ... }:

{
  hm.programs.starship.settings.format = lib.concatStrings
  [

    # Everything not specified below
    "$all"

    # TODO: find out why this isn't working, and it's still on the right
    "$direnv"
    "$git_branch"

    "$fill"

    "$custom"
    "$cmd_duration"
    "$time"
    "$line_break"
    "$character"
  ];

}

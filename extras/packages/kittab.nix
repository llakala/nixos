{ llakaLib, ... }:

/*
Wrapping script around Kitty, to open new tabs in the existing OS window
We do some hackiness to get around xdg problems. First, we make the kitty window
use kittab as its name and class, so it doesn't open `kitty.desktop`, and instead stays
confined to `kittab.desktop`. This means we can have kittab in our favorite apps list, and
avoid duplication.
Second, we remove `-e` from argv, because while the `kitty` command seems to work fine with
it, `kitten @ launch` hates it.
*/
llakaLib.writeFishApplication
{
  name = "kittab";

  # Using runtime inputs seems to break things, so we rely on the system version of kitty.

  text =
  /* fish */
  ''
    set socket "unix:@mykitty"

    if [ "$argv[1]" = "-e" ]
        set -e argv[1]
    end

    # Try opening a tab in existing window
    if kitten @ launch --type=tab --to $socket $argv
        kitten @ focus-window --to $socket &> /dev/null

    # If we couln't launch a tab OS window must not exist. Create it.
    else
        kitty --listen-on $socket --class kittab --name kittab $argv
    end
  '';
}

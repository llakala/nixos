{ llakaLib, pkgs, ... }:

llakaLib.writeFishApplication
{
  name = "kittab"; # Wrapping script around Kitty, to open new tabs in the existing OS window

  # Using runtime inputs seems to break things, so we rely on the system version.
  text =
  /* fish */
  ''
    set socket "unix:/tmp/mykitty"

    function good_kitty
      if ! kitten @ focus-window --to $socket &> /dev/null
        # Create new window, with class and name set to reuse the kittab desktop entry
        kitty --detach --directory="~" -o allow_remote_control=yes --listen-on $socket --class kittab --name kittab
      end
      kitten @ focus-window --to $socket &> /dev/null
    end

    if kitten @ launch --type=tab --to $socket &> /dev/null
      # Open tab in existing window
      kitten @ focus-window --to $socket &> /dev/null
    else
      # Create new window, storing to socket
      good_kitty
    end
  '';
}
